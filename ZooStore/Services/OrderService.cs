using System;
using System.Collections.Generic;
using System.Linq;
using Npgsql;
using ZooStore.Infrastructure;
using ZooStore.Models;

namespace ZooStore.Services
{
    internal static class OrderService
    {
        public static List<OrderListItem> GetOrders()
        {
            return Db.Execute(connection =>
            {
                const string sql = @"
                    select
                        o.id,
                        o.order_date,
                        o.delivery_date,
                        coalesce(pp.pickup_point_address, ''),
                        coalesce(u.full_name, ''),
                        coalesce(o.pickup_code, 0),
                        coalesce(s.status_name, ''),
                        coalesce(string_agg(i.item_name || ' x' || oi.quantity, ', ' order by i.item_name), '')
                    from public.orders o
                    left join public.pickup_points pp on pp.id = o.pickup_point
                    left join public.users u on u.id = o.client_full_name
                    left join public.status s on s.id = o.status_fk
                    left join public.orders_items oi on oi.order_id = o.id
                    left join public.items i on i.article = oi.article_fk
                    group by o.id, o.order_date, o.delivery_date, pp.pickup_point_address, u.full_name, o.pickup_code, s.status_name
                    order by o.id desc;";

                var orders = new List<OrderListItem>();

                using (var command = new NpgsqlCommand(sql, connection))
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        orders.Add(new OrderListItem
                        {
                            Id = reader.GetInt32(0),
                            OrderDate = reader.IsDBNull(1) ? (DateTime?)null : reader.GetDateTime(1),
                            DeliveryDate = reader.IsDBNull(2) ? (DateTime?)null : reader.GetDateTime(2),
                            PickupPointAddress = reader.GetString(3),
                            ClientFullName = reader.GetString(4),
                            PickupCode = reader.GetInt32(5),
                            StatusName = reader.GetString(6),
                            ItemsSummary = reader.GetString(7)
                        });
                    }
                }

                return orders;
            });
        }

        public static List<LookupItem> GetPickupPoints()
        {
            return GetLookupItems("select id, coalesce(pickup_point_address, '') from public.pickup_points order by pickup_point_address;");
        }

        public static List<LookupItem> GetStatuses()
        {
            return GetLookupItems("select id, coalesce(status_name, '') from public.status order by id;");
        }

        public static List<LookupItem> GetClients()
        {
            return Db.Execute(connection =>
            {
                const string sql = @"
                    select id, coalesce(full_name, '')
                    from public.users
                    where role_fk = 3
                    order by full_name;";

                var clients = new List<LookupItem>();
                using (var command = new NpgsqlCommand(sql, connection))
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        clients.Add(new LookupItem
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1)
                        });
                    }
                }

                return clients;
            });
        }

        public static List<string> GetAvailableArticles()
        {
            return Db.Execute(connection =>
            {
                const string sql = "select article from public.items order by article;";
                var articles = new List<string>();

                using (var command = new NpgsqlCommand(sql, connection))
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        articles.Add(reader.GetString(0));
                    }
                }

                return articles;
            });
        }

        public static OrderEditItem GetOrderForEdit(int orderId)
        {
            return Db.Execute(connection =>
            {
                const string orderSql = @"
                    select
                        id,
                        coalesce(order_date, now()),
                        coalesce(delivery_date, now()),
                        coalesce(pickup_point, 0),
                        coalesce(client_full_name, 0),
                        coalesce(pickup_code, 0),
                        coalesce(status_fk, 0)
                    from public.orders
                    where id = @id
                    limit 1;";

                OrderEditItem order = null;

                using (var command = new NpgsqlCommand(orderSql, connection))
                {
                    command.Parameters.AddWithValue("@id", orderId);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            order = new OrderEditItem
                            {
                                Id = reader.GetInt32(0),
                                OrderDate = reader.GetDateTime(1),
                                DeliveryDate = reader.GetDateTime(2),
                                PickupPointId = reader.GetInt32(3),
                                ClientId = reader.GetInt32(4),
                                PickupCode = reader.GetInt32(5),
                                StatusId = reader.GetInt32(6),
                                Items = new List<OrderItemEditItem>()
                            };
                        }
                    }
                }

                if (order == null)
                {
                    return null;
                }

                const string itemsSql = @"
                    select article_fk, coalesce(quantity, 0)
                    from public.orders_items
                    where order_id = @orderId
                    order by id;";

                using (var command = new NpgsqlCommand(itemsSql, connection))
                {
                    command.Parameters.AddWithValue("@orderId", orderId);

                    using (var reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            order.Items.Add(new OrderItemEditItem
                            {
                                Article = reader.IsDBNull(0) ? string.Empty : reader.GetString(0),
                                Quantity = reader.GetInt32(1)
                            });
                        }
                    }
                }

                return order;
            });
        }

        public static int GeneratePickupCode()
        {
            return Db.Execute(connection =>
            {
                var random = new Random();

                while (true)
                {
                    var code = random.Next(100000, 999999);

                    const string sql = @"
                        select exists(
                            select 1
                            from public.orders
                            where pickup_code = @code
                        );";

                    using (var command = new NpgsqlCommand(sql, connection))
                    {
                        command.Parameters.AddWithValue("@code", code);
                        var exists = (bool)command.ExecuteScalar();
                        if (!exists)
                        {
                            return code;
                        }
                    }
                }
            });
        }

        public static int GetDefaultNewStatusId()
        {
            return Db.Execute(connection =>
            {
                const string sql = @"
                    select id
                    from public.status
                    where lower(status_name) = lower('Новый')
                    order by id
                    limit 1;";

                using (var command = new NpgsqlCommand(sql, connection))
                {
                    var value = command.ExecuteScalar();
                    if (value != null && value != DBNull.Value)
                    {
                        return Convert.ToInt32(value);
                    }
                }

                const string fallbackSql = "select id from public.status order by id limit 1;";
                using (var command = new NpgsqlCommand(fallbackSql, connection))
                {
                    var value = command.ExecuteScalar();
                    return value == null || value == DBNull.Value ? 0 : Convert.ToInt32(value);
                }
            });
        }

        public static void InsertOrder(OrderEditItem order)
        {
            Db.Execute(connection =>
            {
                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        EnsureOrdersSequence(connection, transaction);

                        const string orderSql = @"
                            insert into public.orders
                            (order_date, delivery_date, pickup_point, client_full_name, pickup_code, status_fk)
                            values
                            (@orderDate, @deliveryDate, @pickupPoint, @clientId, @pickupCode, @statusId)
                            returning id;";

                        int orderId;
                        using (var command = new NpgsqlCommand(orderSql, connection, transaction))
                        {
                            FillOrderCommand(command, order);
                            orderId = Convert.ToInt32(command.ExecuteScalar());
                        }

                        InsertOrderItems(connection, transaction, orderId, order.Items);
                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            });
        }

        public static void UpdateOrder(OrderEditItem order)
        {
            Db.Execute(connection =>
            {
                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        const string updateSql = @"
                            update public.orders
                            set
                                order_date = @orderDate,
                                delivery_date = @deliveryDate,
                                pickup_point = @pickupPoint,
                                client_full_name = @clientId,
                                pickup_code = @pickupCode,
                                status_fk = @statusId
                            where id = @id;";

                        using (var command = new NpgsqlCommand(updateSql, connection, transaction))
                        {
                            FillOrderCommand(command, order);
                            command.Parameters.AddWithValue("@id", order.Id);
                            command.ExecuteNonQuery();
                        }

                        using (var deleteItemsCommand = new NpgsqlCommand("delete from public.orders_items where order_id = @id;", connection, transaction))
                        {
                            deleteItemsCommand.Parameters.AddWithValue("@id", order.Id);
                            deleteItemsCommand.ExecuteNonQuery();
                        }

                        InsertOrderItems(connection, transaction, order.Id, order.Items);
                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            });
        }

        public static void DeleteOrder(int orderId)
        {
            Db.Execute(connection =>
            {
                using (var transaction = connection.BeginTransaction())
                {
                    try
                    {
                        using (var deleteItems = new NpgsqlCommand("delete from public.orders_items where order_id = @id;", connection, transaction))
                        {
                            deleteItems.Parameters.AddWithValue("@id", orderId);
                            deleteItems.ExecuteNonQuery();
                        }

                        using (var deleteOrder = new NpgsqlCommand("delete from public.orders where id = @id;", connection, transaction))
                        {
                            deleteOrder.Parameters.AddWithValue("@id", orderId);
                            deleteOrder.ExecuteNonQuery();
                        }

                        transaction.Commit();
                    }
                    catch
                    {
                        transaction.Rollback();
                        throw;
                    }
                }
            });
        }

        private static void InsertOrderItems(NpgsqlConnection connection, NpgsqlTransaction transaction, int orderId, List<OrderItemEditItem> items)
        {
            const string itemSql = @"
                insert into public.orders_items
                (order_id, article_fk, quantity)
                values
                (@orderId, @article, @quantity);";

            foreach (var item in items ?? Enumerable.Empty<OrderItemEditItem>())
            {
                using (var command = new NpgsqlCommand(itemSql, connection, transaction))
                {
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@article", item.Article);
                    command.Parameters.AddWithValue("@quantity", item.Quantity);
                    command.ExecuteNonQuery();
                }
            }
        }

        private static void EnsureOrdersSequence(NpgsqlConnection connection, NpgsqlTransaction transaction)
        {
            const string sql = @"
                select setval(
                    pg_get_serial_sequence('public.orders', 'id'),
                    coalesce((select max(id) from public.orders), 0) + 1,
                    false
                );";

            using (var command = new NpgsqlCommand(sql, connection, transaction))
            {
                command.ExecuteNonQuery();
            }
        }

        private static void FillOrderCommand(NpgsqlCommand command, OrderEditItem order)
        {
            command.Parameters.AddWithValue("@orderDate", order.OrderDate);
            command.Parameters.AddWithValue("@deliveryDate", order.DeliveryDate);
            command.Parameters.AddWithValue("@pickupPoint", order.PickupPointId);
            command.Parameters.AddWithValue("@clientId", order.ClientId);
            command.Parameters.AddWithValue("@pickupCode", order.PickupCode);
            command.Parameters.AddWithValue("@statusId", order.StatusId);
        }

        private static List<LookupItem> GetLookupItems(string sql)
        {
            return Db.Execute(connection =>
            {
                var items = new List<LookupItem>();

                using (var command = new NpgsqlCommand(sql, connection))
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        items.Add(new LookupItem
                        {
                            Id = reader.GetInt32(0),
                            Name = reader.GetString(1)
                        });
                    }
                }

                return items;
            });
        }
    }
}
