using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using ZooStore.Models;
using ZooStore.Services;

namespace ZooStore
{
    public partial class FormProducts : Form
    {
        private const string AllProvidersText = "Все поставщики";

        private readonly List<ProductListItem> allProducts = new List<ProductListItem>();
        private FormAddProduct activeProductEditor;
        private UserControlProduct selectedProductControl;
        private string selectedProductArticle;

        public FormProducts()
        {
            InitializeComponent();
            ConfigureForm();
        }

        private void ConfigureForm()
        {
            Text = "Товары";
            StartPosition = FormStartPosition.CenterScreen;
            buttonBack.Text = "Выход";

            comboBoxProvider.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBoxSort.DropDownStyle = ComboBoxStyle.DropDownList;

            buttonBack.Click += ButtonBack_Click;
            buttonDeleteProduct.Click += ButtonDeleteProduct_Click;
            buttonOrders.Click += ButtonOrders_Click;
            Load += FormProducts_Load;
            textBoxSearch.TextChanged += FiltersChanged;
            comboBoxProvider.SelectedIndexChanged += FiltersChanged;
            comboBoxSort.SelectedIndexChanged += FiltersChanged;
        }

        private void FormProducts_Load(object sender, EventArgs e)
        {
            try
            {
                ApplySessionState();
                ConfigureFilterControlsByRole();
                ConfigureSortOptions();
                LoadProducts();
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "загрузить список товаров");
            }
        }

        private void ApplySessionState()
        {
            var user = AppSession.CurrentUser;
            if (user == null)
            {
                DialogService.ShowWarning(
                    "Сессия пользователя не найдена. Выполните вход заново.",
                    "Требуется вход");
                Close();
                return;
            }

            labelFullName.Text = string.IsNullOrWhiteSpace(user.FullName) ? user.Login : user.FullName;
        }

        private void ConfigureFilterControlsByRole()
        {
            var user = AppSession.CurrentUser;
            var canUseAdvancedFilters = user != null
                && (user.Role == UserRole.Admin || user.Role == UserRole.Manager);
            var canAddProducts = user != null && user.Role == UserRole.Admin;
            var canOpenOrders = user != null
                && (user.Role == UserRole.Admin || user.Role == UserRole.Manager);

            labelSearch.Visible = canUseAdvancedFilters;
            textBoxSearch.Visible = canUseAdvancedFilters;
            labelProvider.Visible = canUseAdvancedFilters;
            comboBoxProvider.Visible = canUseAdvancedFilters;
            labelSort.Visible = canUseAdvancedFilters;
            comboBoxSort.Visible = canUseAdvancedFilters;
            buttonAddProduct.Visible = canAddProducts;
            buttonDeleteProduct.Visible = canAddProducts;
            buttonOrders.Visible = canOpenOrders;

            if (!canUseAdvancedFilters)
            {
                textBoxSearch.Clear();
            }
        }

        private void ConfigureSortOptions()
        {
            comboBoxSort.Items.Clear();
            comboBoxSort.Items.Add("Без сортировки");
            comboBoxSort.Items.Add("Количество по возрастанию");
            comboBoxSort.Items.Add("Количество по убыванию");
            comboBoxSort.SelectedIndex = 0;
        }

        private void LoadProducts()
        {
            allProducts.Clear();
            allProducts.AddRange(ProductService.GetProducts());
            ConfigureProviderFilter();
            ApplyFilters();
        }

        private void ConfigureProviderFilter()
        {
            var currentProvider = comboBoxProvider.SelectedItem as string;
            var providers = allProducts
                .Select(product => product.Provider)
                .Where(provider => !string.IsNullOrWhiteSpace(provider))
                .Distinct(StringComparer.CurrentCultureIgnoreCase)
                .OrderBy(provider => provider)
                .ToList();

            comboBoxProvider.Items.Clear();
            comboBoxProvider.Items.Add(AllProvidersText);

            foreach (var provider in providers)
            {
                comboBoxProvider.Items.Add(provider);
            }

            if (!string.IsNullOrWhiteSpace(currentProvider) && comboBoxProvider.Items.Contains(currentProvider))
            {
                comboBoxProvider.SelectedItem = currentProvider;
            }
            else
            {
                comboBoxProvider.SelectedIndex = 0;
            }
        }

        private void FiltersChanged(object sender, EventArgs e)
        {
            try
            {
                ApplyFilters();
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "обновить список товаров");
            }
        }

        private void ApplyFilters()
        {
            IEnumerable<ProductListItem> filteredProducts = allProducts;

            if (textBoxSearch.Visible)
            {
                var searchText = textBoxSearch.Text.Trim();
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    filteredProducts = filteredProducts.Where(product => MatchesSearch(product, searchText));
                }

                var selectedProvider = comboBoxProvider.SelectedItem as string;
                if (!string.IsNullOrWhiteSpace(selectedProvider) && selectedProvider != AllProvidersText)
                {
                    filteredProducts = filteredProducts.Where(product =>
                        string.Equals(product.Provider, selectedProvider, StringComparison.CurrentCultureIgnoreCase));
                }

                filteredProducts = ApplySort(filteredProducts);
            }

            RenderProducts(filteredProducts.ToList());
        }

        private static bool MatchesSearch(ProductListItem product, string searchText)
        {
            return ContainsText(product.Name, searchText)
                || ContainsText(product.Description, searchText)
                || ContainsText(product.Manufacturer, searchText)
                || ContainsText(product.Provider, searchText);
        }

        private static bool ContainsText(string source, string searchText)
        {
            return !string.IsNullOrWhiteSpace(source)
                && source.IndexOf(searchText, StringComparison.CurrentCultureIgnoreCase) >= 0;
        }

        private IEnumerable<ProductListItem> ApplySort(IEnumerable<ProductListItem> products)
        {
            switch (comboBoxSort.SelectedIndex)
            {
                case 1:
                    return products.OrderBy(product => product.Quantity).ThenBy(product => product.Name);
                case 2:
                    return products.OrderByDescending(product => product.Quantity).ThenBy(product => product.Name);
                default:
                    return products;
            }
        }

        private void RenderProducts(List<ProductListItem> products)
        {
            flowLayoutPanelProducts.SuspendLayout();
            flowLayoutPanelProducts.Controls.Clear();
            selectedProductControl = null;
            selectedProductArticle = null;

            foreach (var product in products)
            {
                var productControl = new UserControlProduct();
                productControl.Bind(product);
                productControl.Selected += ProductControl_Selected;

                if (CanEditProducts())
                {
                    productControl.EditRequested += ProductControl_EditRequested;
                }

                flowLayoutPanelProducts.Controls.Add(productControl);
            }

            flowLayoutPanelProducts.ResumeLayout();
        }

        private void ButtonAddProduct_Click(object sender, EventArgs e)
        {
            OpenProductEditor(null);
        }

        private void buttonAddProduct_Click_1(object sender, EventArgs e)
        {
            ButtonAddProduct_Click(sender, e);
        }

        private void ProductControl_EditRequested(object sender, EventArgs e)
        {
            var productControl = sender as UserControlProduct;
            if (productControl == null)
            {
                return;
            }

            OpenProductEditor(productControl.ProductArticle);
        }

        private void ProductControl_Selected(object sender, EventArgs e)
        {
            var productControl = sender as UserControlProduct;
            if (productControl == null)
            {
                return;
            }

            if (selectedProductControl != null && !selectedProductControl.IsDisposed)
            {
                selectedProductControl.IsSelected = false;
            }

            selectedProductControl = productControl;
            selectedProductArticle = productControl.ProductArticle;
            selectedProductControl.IsSelected = true;
        }

        private void OpenProductEditor(string article)
        {
            if (!CanEditProducts())
            {
                return;
            }

            if (activeProductEditor != null && !activeProductEditor.IsDisposed)
            {
                activeProductEditor.Focus();
                return;
            }

            activeProductEditor = new FormAddProduct(article);
            activeProductEditor.FormClosed += ActiveProductEditor_FormClosed;

            if (activeProductEditor.ShowDialog(this) == DialogResult.OK)
            {
                LoadProducts();
            }
        }

        private void ActiveProductEditor_FormClosed(object sender, FormClosedEventArgs e)
        {
            if (activeProductEditor != null)
            {
                activeProductEditor.FormClosed -= ActiveProductEditor_FormClosed;
            }

            activeProductEditor = null;
        }

        private void ButtonDeleteProduct_Click(object sender, EventArgs e)
        {
            try
            {
                if (!CanEditProducts())
                {
                    return;
                }

                if (string.IsNullOrWhiteSpace(selectedProductArticle))
                {
                    DialogService.ShowWarning(
                        "Сначала выберите товар, который нужно удалить.",
                        "Товар не выбран");
                    return;
                }

                if (ProductService.IsProductUsedInOrders(selectedProductArticle))
                {
                    DialogService.ShowWarning(
                        "Этот товар уже используется в заказах, поэтому удалить его нельзя.\nУдалите товар из заказов или оставьте его в справочнике.",
                        "Удаление запрещено");
                    return;
                }

                if (!DialogService.Confirm(
                    "Удалить выбранный товар без возможности восстановления?",
                    "Подтвердите удаление"))
                {
                    return;
                }

                ProductService.DeleteProduct(selectedProductArticle);
                selectedProductArticle = null;
                selectedProductControl = null;
                LoadProducts();
                DialogService.ShowInfo("Товар успешно удален.");
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "удалить товар");
            }
        }

        private bool CanEditProducts()
        {
            var user = AppSession.CurrentUser;
            return user != null && user.Role == UserRole.Admin;
        }

        private void ButtonOrders_Click(object sender, EventArgs e)
        {
            var user = AppSession.CurrentUser;
            if (user == null || (user.Role != UserRole.Admin && user.Role != UserRole.Manager))
            {
                return;
            }

            using (var formOrders = new FormOrders())
            {
                formOrders.ShowDialog(this);
            }
        }

        private void ButtonBack_Click(object sender, EventArgs e)
        {
            AppSession.SignOut();
            Close();
        }

        private void labelFullName_Click(object sender, EventArgs e)
        {
        }
    }
}
