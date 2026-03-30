using System;
using System.Drawing;
using System.Windows.Forms;
using ZooStore.Models;

namespace ZooStore
{
    public partial class UserControlOrder : UserControl
    {
        private const string DefaultText = "Не указано";

        public event EventHandler Selected;
        public event EventHandler EditRequested;

        public UserControlOrder()
        {
            InitializeComponent();
            ConfigureLayout();
        }

        internal int OrderId { get; private set; }

        internal bool IsSelected
        {
            get { return panelOrderCard.BackColor == Color.Gainsboro; }
            set { panelOrderCard.BackColor = value ? Color.Gainsboro : Color.White; }
        }

        internal void Bind(OrderListItem order)
        {
            if (order == null)
            {
                throw new ArgumentNullException("order");
            }

            OrderId = order.Id;
            labelOrderTitle.Text = "Заказ №" + order.Id;
            labelOrderDateValue.Text = FormatDate(order.OrderDate);
            labelDeliveryDateValue.Text = FormatDate(order.DeliveryDate);
            labelPickupPointValue.Text = GetText(order.PickupPointAddress);
            labelClientValue.Text = GetText(order.ClientFullName);
            labelPickupCodeValue.Text = order.PickupCode.ToString();
            labelStatusValue.Text = GetText(order.StatusName);
            labelItemsValue.Text = GetText(order.ItemsSummary);
        }

        private void ConfigureLayout()
        {
            HookClick(this);
            HookDoubleClick(this);
        }

        private void HookClick(Control control)
        {
            control.Click += Control_Click;

            foreach (Control child in control.Controls)
            {
                HookClick(child);
            }
        }

        private void HookDoubleClick(Control control)
        {
            control.DoubleClick += Control_DoubleClick;

            foreach (Control child in control.Controls)
            {
                HookDoubleClick(child);
            }
        }

        private void Control_Click(object sender, EventArgs e)
        {
            if (Selected != null)
            {
                Selected(this, EventArgs.Empty);
            }
        }

        private void Control_DoubleClick(object sender, EventArgs e)
        {
            if (EditRequested != null)
            {
                EditRequested(this, EventArgs.Empty);
            }
        }

        private static string FormatDate(DateTime? date)
        {
            return date.HasValue ? date.Value.ToString("dd.MM.yyyy") : "Не указана";
        }

        private static string GetText(string value)
        {
            return string.IsNullOrWhiteSpace(value) ? DefaultText : value.Trim();
        }
    }
}
