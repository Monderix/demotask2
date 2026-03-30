using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using ZooStore.Models;
using ZooStore.Services;

namespace ZooStore
{
    public partial class FormEditOrder : Form
    {
        private readonly int? orderId;
        private readonly HashSet<string> availableArticles = new HashSet<string>(StringComparer.CurrentCultureIgnoreCase);

        public FormEditOrder()
            : this(null)
        {
        }

        public FormEditOrder(int? orderId)
        {
            InitializeComponent();
            this.orderId = orderId;
            ConfigureForm();
        }

        private bool IsEditMode
        {
            get { return orderId.HasValue; }
        }

        private void ConfigureForm()
        {
            Text = IsEditMode ? "Редактирование заказа" : "Добавление заказа";
            StartPosition = FormStartPosition.CenterParent;

            comboBoxStatus.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBoxPickupPoint.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBoxClient.DropDownStyle = ComboBoxStyle.DropDownList;

            dateTimePickerOrder.Format = DateTimePickerFormat.Custom;
            dateTimePickerOrder.CustomFormat = "dd.MM.yyyy HH:mm";
            dateTimePickerDelivery.Format = DateTimePickerFormat.Custom;
            dateTimePickerDelivery.CustomFormat = "dd.MM.yyyy HH:mm";

            buttonSave.Click += ButtonSave_Click;
            buttonBack.Click += ButtonBack_Click;
            Load += FormEditOrder_Load;
        }

        private void FormEditOrder_Load(object sender, EventArgs e)
        {
            try
            {
                EnsureAdminAccess();
                LoadLookups();
                InitializeDefaultValues();

                if (IsEditMode)
                {
                    LoadOrder();
                }
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "загрузить форму заказа");
                DialogResult = DialogResult.Cancel;
                Close();
            }
        }

        private static void EnsureAdminAccess()
        {
            var user = AppSession.CurrentUser;
            if (user != null && user.Role == UserRole.Admin)
            {
                return;
            }

            throw new InvalidOperationException("Редактирование заказов доступно только администратору.");
        }

        private void LoadLookups()
        {
            BindLookup(comboBoxStatus, OrderService.GetStatuses());
            BindLookup(comboBoxPickupPoint, OrderService.GetPickupPoints());
            BindLookup(comboBoxClient, OrderService.GetClients());

            availableArticles.Clear();
            foreach (var article in OrderService.GetAvailableArticles())
            {
                availableArticles.Add(article);
            }
        }

        private void InitializeDefaultValues()
        {
            if (!IsEditMode)
            {
                dateTimePickerOrder.Value = DateTime.Now;
                dateTimePickerOrder.Enabled = false;
                dateTimePickerDelivery.Value = DateTime.Now.AddDays(1);
                textBoxPickupCode.Text = OrderService.GeneratePickupCode().ToString();

                var newStatusId = OrderService.GetDefaultNewStatusId();
                SelectLookupItem(comboBoxStatus, newStatusId);
            }
        }

        private void LoadOrder()
        {
            var order = OrderService.GetOrderForEdit(orderId.Value);
            if (order == null)
            {
                throw new InvalidOperationException("Заказ для редактирования не найден.");
            }

            Text = "Редактирование заказа №" + order.Id;
            dateTimePickerOrder.Enabled = true;
            textBoxArticle.Text = string.Join(Environment.NewLine, order.Items.Select(item => item.Article + ":" + item.Quantity));
            dateTimePickerOrder.Value = order.OrderDate;
            dateTimePickerDelivery.Value = order.DeliveryDate;
            textBoxPickupCode.Text = order.PickupCode.ToString();

            SelectLookupItem(comboBoxStatus, order.StatusId);
            SelectLookupItem(comboBoxPickupPoint, order.PickupPointId);
            SelectLookupItem(comboBoxClient, order.ClientId);
        }

        private void ButtonSave_Click(object sender, EventArgs e)
        {
            try
            {
                var order = BuildOrderModel();

                if (IsEditMode)
                {
                    OrderService.UpdateOrder(order);
                }
                else
                {
                    OrderService.InsertOrder(order);
                }

                DialogResult = DialogResult.OK;
                Close();
            }
            catch (InvalidOperationException exception)
            {
                DialogService.ShowWarning(exception.Message, "Проверьте данные");
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "сохранить заказ");
            }
        }

        private OrderEditItem BuildOrderModel()
        {
            int pickupCode;
            if (!int.TryParse(textBoxPickupCode.Text.Trim(), out pickupCode))
            {
                throw new InvalidOperationException("Введите корректный код получения.");
            }

            var items = ParseOrderItems(textBoxArticle.Text);
            if (items.Count == 0)
            {
                throw new InvalidOperationException("Добавьте хотя бы одну позицию заказа.");
            }

            return new OrderEditItem
            {
                Id = orderId ?? 0,
                OrderDate = dateTimePickerOrder.Value,
                DeliveryDate = dateTimePickerDelivery.Value,
                PickupPointId = GetSelectedLookupId(comboBoxPickupPoint, "пункта выдачи"),
                ClientId = GetSelectedLookupId(comboBoxClient, "клиента"),
                PickupCode = pickupCode,
                StatusId = GetSelectedLookupId(comboBoxStatus, "статуса"),
                Items = items
            };
        }

        private List<OrderItemEditItem> ParseOrderItems(string source)
        {
            var items = new List<OrderItemEditItem>();
            var lines = source
                .Split(new[] { "\r\n", "\n" }, StringSplitOptions.RemoveEmptyEntries)
                .Select(line => line.Trim())
                .Where(line => line.Length > 0)
                .ToList();

            foreach (var line in lines)
            {
                var parts = line.Split(':');
                if (parts.Length != 2)
                {
                    throw new InvalidOperationException("Позиции заказа заполняются в формате артикул:количество.");
                }

                var article = parts[0].Trim();
                var quantityText = parts[1].Trim();
                int quantity;

                if (string.IsNullOrWhiteSpace(article) || !availableArticles.Contains(article))
                {
                    throw new InvalidOperationException("Артикул '" + article + "' не найден в товарах.");
                }

                if (!int.TryParse(quantityText, out quantity) || quantity <= 0)
                {
                    throw new InvalidOperationException("Количество для артикула '" + article + "' должно быть положительным числом.");
                }

                items.Add(new OrderItemEditItem
                {
                    Article = article,
                    Quantity = quantity
                });
            }

            return items;
        }

        private void ButtonBack_Click(object sender, EventArgs e)
        {
            Close();
        }

        private static void BindLookup(ComboBox comboBox, List<LookupItem> items)
        {
            comboBox.DataSource = items;
            comboBox.DisplayMember = "Name";
            comboBox.ValueMember = "Id";
        }

        private static void SelectLookupItem(ComboBox comboBox, int id)
        {
            var item = (comboBox.DataSource as IEnumerable<LookupItem>)?.FirstOrDefault(x => x.Id == id);
            if (item != null)
            {
                comboBox.SelectedItem = item;
            }
        }

        private static int GetSelectedLookupId(ComboBox comboBox, string fieldName)
        {
            var selectedItem = comboBox.SelectedItem as LookupItem;
            if (selectedItem == null)
            {
                throw new InvalidOperationException("Выберите значение для " + fieldName + ".");
            }

            return selectedItem.Id;
        }
    }
}
