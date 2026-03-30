using System;
using System.Collections.Generic;
using System.Windows.Forms;
using ZooStore.Models;
using ZooStore.Services;

namespace ZooStore
{
    public partial class FormOrders : Form
    {
        private UserControlOrder selectedOrderControl;
        private int? selectedOrderId;
        private FormEditOrder activeOrderEditor;

        public FormOrders()
        {
            InitializeComponent();
            ConfigureForm();
        }

        private void ConfigureForm()
        {
            Text = "Заказы";
            StartPosition = FormStartPosition.CenterParent;
            buttonBack.Click += ButtonBack_Click;
            buttonAddOrder.Click += ButtonAddOrder_Click;
            buttonEditOrder.Click += ButtonEditOrder_Click;
            buttonDeleteOrder.Click += ButtonDeleteOrder_Click;
            Load += FormOrders_Load;
        }

        private void FormOrders_Load(object sender, EventArgs e)
        {
            try
            {
                EnsureOrdersAccess();
                ConfigureByRole();
                LoadOrders();
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "загрузить список заказов");
            }
        }

        private void EnsureOrdersAccess()
        {
            var user = AppSession.CurrentUser;
            if (user != null && (user.Role == UserRole.Admin || user.Role == UserRole.Manager))
            {
                return;
            }

            DialogService.ShowWarning(
                "Просмотр заказов доступен только администратору и менеджеру.",
                "Недостаточно прав");
            DialogResult = DialogResult.Cancel;
            Close();
        }

        private void ConfigureByRole()
        {
            var user = AppSession.CurrentUser;
            var isAdmin = user != null && user.Role == UserRole.Admin;
            buttonAddOrder.Visible = isAdmin;
            buttonEditOrder.Visible = isAdmin;
            buttonDeleteOrder.Visible = isAdmin;
        }

        private void LoadOrders()
        {
            RenderOrders(OrderService.GetOrders());
        }

        private void RenderOrders(List<OrderListItem> orders)
        {
            flowLayoutPanelProducts.SuspendLayout();
            flowLayoutPanelProducts.Controls.Clear();
            selectedOrderId = null;
            selectedOrderControl = null;

            foreach (var order in orders)
            {
                var orderControl = new UserControlOrder();
                orderControl.Width = Math.Max(730, flowLayoutPanelProducts.ClientSize.Width - 20);
                orderControl.Bind(order);
                orderControl.Selected += OrderControl_Selected;

                if (CanEditOrders())
                {
                    orderControl.EditRequested += OrderControl_EditRequested;
                }

                flowLayoutPanelProducts.Controls.Add(orderControl);
            }

            flowLayoutPanelProducts.ResumeLayout();
        }

        private void OrderControl_Selected(object sender, EventArgs e)
        {
            var orderControl = sender as UserControlOrder;
            if (orderControl == null)
            {
                return;
            }

            if (selectedOrderControl != null && !selectedOrderControl.IsDisposed)
            {
                selectedOrderControl.IsSelected = false;
            }

            selectedOrderControl = orderControl;
            selectedOrderId = orderControl.OrderId;
            selectedOrderControl.IsSelected = true;
        }

        private void OrderControl_EditRequested(object sender, EventArgs e)
        {
            if (CanEditOrders())
            {
                ButtonEditOrder_Click(sender, e);
            }
        }

        private void ButtonAddOrder_Click(object sender, EventArgs e)
        {
            OpenOrderEditor(null);
        }

        private void ButtonEditOrder_Click(object sender, EventArgs e)
        {
            if (!CanEditOrders())
            {
                return;
            }

            if (!selectedOrderId.HasValue)
            {
                DialogService.ShowWarning("Сначала выберите заказ для редактирования.", "Заказ не выбран");
                return;
            }

            OpenOrderEditor(selectedOrderId);
        }

        private void ButtonDeleteOrder_Click(object sender, EventArgs e)
        {
            try
            {
                if (!CanEditOrders())
                {
                    return;
                }

                if (!selectedOrderId.HasValue)
                {
                    DialogService.ShowWarning("Сначала выберите заказ для удаления.", "Заказ не выбран");
                    return;
                }

                if (!DialogService.Confirm("Удалить выбранный заказ вместе с его позициями?", "Подтвердите удаление"))
                {
                    return;
                }

                OrderService.DeleteOrder(selectedOrderId.Value);
                LoadOrders();
                DialogService.ShowInfo("Заказ успешно удален.");
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "удалить заказ");
            }
        }

        private void OpenOrderEditor(int? orderId)
        {
            if (!CanEditOrders())
            {
                return;
            }

            if (activeOrderEditor != null && !activeOrderEditor.IsDisposed)
            {
                activeOrderEditor.Focus();
                return;
            }

            activeOrderEditor = new FormEditOrder(orderId);
            activeOrderEditor.FormClosed += ActiveOrderEditor_FormClosed;

            if (activeOrderEditor.ShowDialog(this) == DialogResult.OK)
            {
                LoadOrders();
            }
        }

        private void ActiveOrderEditor_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (activeOrderEditor != null)
            {
                activeOrderEditor.FormClosed -= ActiveOrderEditor_FormClosed;
            }

            activeOrderEditor = null;
        }

        private bool CanEditOrders()
        {
            var user = AppSession.CurrentUser;
            return user != null && user.Role == UserRole.Admin;
        }

        private void ButtonBack_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
