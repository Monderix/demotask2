using System;
using System.Collections.Generic;
using Npgsql;
using ZooStore.Infrastructure;
using ZooStore.Models;

namespace ZooStore.Services
{
    internal static class ProductService
    {
        public static List<ProductListItem> GetProducts()
        {
            return Db.Execute(connection =>
            {
                const string sql = @"
                    select
                        i.article,
                        coalesce(i.item_name, ''),
                        coalesce(c.category_pk, ''),
                        coalesce(i.description, ''),
                        coalesce(m.manufacturer_pk, ''),
                        coalesce(p.provider_pk, ''),
                        coalesce(me.measurement_pk, ''),
                        coalesce(i.cost, 0),
                        coalesce(i.discount, 0),
                        coalesce(i.quantity, 0),
                        coalesce(i.picture, '')
                    from public.items i
                    left join public.categories c on c.id = i.category_fk
                    left join public.manufacturers m on m.id = i.manufacturer_fk
                    left join public.providers p on p.id = i.provider_fk
                    left join public.measurement me on me.id = i.measurement_fk
                    order by i.item_name nulls last, i.article;";

                var products = new List<ProductListItem>();

                using (var command = new NpgsqlCommand(sql, connection))
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        products.Add(new ProductListItem
                        {
                            Article = reader.GetString(0),
                            Name = reader.GetString(1),
                            Category = reader.GetString(2),
                            Description = reader.GetString(3),
                            Manufacturer = reader.GetString(4),
                            Provider = reader.GetString(5),
                            Measurement = reader.GetString(6),
                            Cost = reader.GetInt32(7),
                            Discount = reader.GetInt32(8),
                            Quantity = reader.GetInt32(9),
                            PicturePath = reader.GetString(10)
                        });
                    }
                }

                return products;
            });
        }

        public static List<LookupItem> GetCategories()
        {
            return GetLookupItems("select id, coalesce(category_pk, '') from public.categories order by category_pk;");
        }

        public static List<LookupItem> GetManufacturers()
        {
            return GetLookupItems("select id, coalesce(manufacturer_pk, '') from public.manufacturers order by manufacturer_pk;");
        }

        public static List<LookupItem> GetProviders()
        {
            return GetLookupItems("select id, coalesce(provider_pk, '') from public.providers order by provider_pk;");
        }

        public static List<LookupItem> GetMeasurements()
        {
            return GetLookupItems("select id, coalesce(measurement_pk, '') from public.measurement order by measurement_pk;");
        }

        public static ProductEditItem GetProductForEdit(string article)
        {
            return Db.Execute(connection =>
            {
                const string sql = @"
                    select
                        article,
                        coalesce(item_name, ''),
                        coalesce(category_fk, 0),
                        coalesce(description, ''),
                        coalesce(manufacturer_fk, 0),
                        coalesce(provider_fk, 0),
                        coalesce(cost, 0),
                        coalesce(measurement_fk, 0),
                        coalesce(quantity, 0),
                        coalesce(discount, 0),
                        coalesce(picture, '')
                    from public.items
                    where article = @article
                    limit 1;";

                using (var command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@article", article);

                    using (var reader = command.ExecuteReader())
                    {
                        if (!reader.Read())
                        {
                            return null;
                        }

                        return new ProductEditItem
                        {
                            Article = reader.GetString(0),
                            Name = reader.GetString(1),
                            CategoryId = reader.GetInt32(2),
                            Description = reader.GetString(3),
                            ManufacturerId = reader.GetInt32(4),
                            ProviderId = reader.GetInt32(5),
                            Cost = reader.GetInt32(6),
                            MeasurementId = reader.GetInt32(7),
                            Quantity = reader.GetInt32(8),
                            Discount = reader.GetInt32(9),
                            PicturePath = reader.GetString(10)
                        };
                    }
                }
            });
        }

        public static string InsertProduct(ProductEditItem product)
        {
            var article = GenerateArticle();

            Db.Execute(connection =>
            {
                const string sql = @"
                    insert into public.items
                    (
                        article, item_name, measurement_fk, cost, provider_fk,
                        manufacturer_fk, category_fk, discount, quantity, description, picture
                    )
                    values
                    (
                        @article, @name, @measurementId, @cost, @providerId,
                        @manufacturerId, @categoryId, @discount, @quantity, @description, @picture
                    );";

                using (var command = new NpgsqlCommand(sql, connection))
                {
                    FillProductCommand(command, article, product);
                    command.ExecuteNonQuery();
                }
            });

            return article;
        }

        public static void UpdateProduct(ProductEditItem product)
        {
            Db.Execute(connection =>
            {
                const string sql = @"
                    update public.items
                    set
                        item_name = @name,
                        measurement_fk = @measurementId,
                        cost = @cost,
                        provider_fk = @providerId,
                        manufacturer_fk = @manufacturerId,
                        category_fk = @categoryId,
                        discount = @discount,
                        quantity = @quantity,
                        description = @description,
                        picture = @picture
                    where article = @article;";

                using (var command = new NpgsqlCommand(sql, connection))
                {
                    FillProductCommand(command, product.Article, product);
                    command.ExecuteNonQuery();
                }
            });
        }

        public static bool IsProductUsedInOrders(string article)
        {
            return Db.Execute(connection =>
            {
                const string sql = @"
                    select exists(
                        select 1
                        from public.orders_items
                        where article_fk = @article
                    );";

                using (var command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@article", article);
                    return (bool)command.ExecuteScalar();
                }
            });
        }

        public static void DeleteProduct(string article)
        {
            Db.Execute(connection =>
            {
                const string sql = @"
                    delete from public.items
                    where article = @article;";

                using (var command = new NpgsqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@article", article);
                    command.ExecuteNonQuery();
                }
            });
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

        private static void FillProductCommand(NpgsqlCommand command, string article, ProductEditItem product)
        {
            command.Parameters.AddWithValue("@article", article);
            command.Parameters.AddWithValue("@name", product.Name);
            command.Parameters.AddWithValue("@measurementId", product.MeasurementId);
            command.Parameters.AddWithValue("@cost", product.Cost);
            command.Parameters.AddWithValue("@providerId", product.ProviderId);
            command.Parameters.AddWithValue("@manufacturerId", product.ManufacturerId);
            command.Parameters.AddWithValue("@categoryId", product.CategoryId);
            command.Parameters.AddWithValue("@discount", product.Discount);
            command.Parameters.AddWithValue("@quantity", product.Quantity);
            command.Parameters.AddWithValue("@description", product.Description);
            command.Parameters.AddWithValue("@picture", Db.DbValue(product.PicturePath));
        }

        private static string GenerateArticle()
        {
            return "ART-" + Guid.NewGuid().ToString("N").Substring(0, 12).ToUpperInvariant();
        }
    }
}
