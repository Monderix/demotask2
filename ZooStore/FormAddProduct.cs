using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using ZooStore.Infrastructure;
using ZooStore.Models;
using ZooStore.Services;

namespace ZooStore
{
    public partial class FormAddProduct : Form
    {
        private readonly string article;
        private string originalPicturePath;
        private string currentPicturePath;
        private string selectedImageFilePath;

        public FormAddProduct()
            : this(null)
        {
        }

        public FormAddProduct(string article)
        {
            InitializeComponent();
            this.article = article;
            ConfigureForm();
        }

        private bool IsEditMode
        {
            get { return !string.IsNullOrWhiteSpace(article); }
        }

        private void ConfigureForm()
        {
            Text = IsEditMode ? "Редактирование товара" : "Добавление товара";
            StartPosition = FormStartPosition.CenterParent;
            pictureBoxEditProduct.SizeMode = PictureBoxSizeMode.Zoom;

            comboBoxCategory.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBoxManufacturer.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBoxProvider.DropDownStyle = ComboBoxStyle.DropDownList;
            comboBoxMeasurement.DropDownStyle = ComboBoxStyle.DropDownList;

            buttonBack.Click += ButtonBack_Click;
            buttonSave.Click += ButtonSave_Click;
            buttonAddPicture.Click += ButtonAddPicture_Click;
            Load += FormAddProduct_Load;
        }

        private void FormAddProduct_Load(object sender, EventArgs e)
        {
            try
            {
                EnsureAdminAccess();
                LoadLookups();
                ReplacePreviewImage(new Bitmap(AppResources.PicturePlaceholder));

                if (IsEditMode)
                {
                    LoadProduct();
                }
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "загрузить форму товара");
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

            throw new InvalidOperationException("Добавление и редактирование товаров доступно только администратору.");
        }

        private void LoadLookups()
        {
            BindLookup(comboBoxCategory, ProductService.GetCategories());
            BindLookup(comboBoxManufacturer, ProductService.GetManufacturers());
            BindLookup(comboBoxProvider, ProductService.GetProviders());
            BindLookup(comboBoxMeasurement, ProductService.GetMeasurements());
        }

        private void LoadProduct()
        {
            var product = ProductService.GetProductForEdit(article);
            if (product == null)
            {
                throw new InvalidOperationException("Товар для редактирования не найден.");
            }

            Text = "Редактирование товара: " + product.Article;
            textBoxName.Text = product.Name;
            textBoxDescription.Text = product.Description;
            textBoxCost.Text = product.Cost.ToString();
            textBoxQuantity.Text = product.Quantity.ToString();
            textBoxDiscount.Text = product.Discount.ToString();

            SelectLookupItem(comboBoxCategory, product.CategoryId);
            SelectLookupItem(comboBoxManufacturer, product.ManufacturerId);
            SelectLookupItem(comboBoxProvider, product.ProviderId);
            SelectLookupItem(comboBoxMeasurement, product.MeasurementId);

            currentPicturePath = product.PicturePath;
            originalPicturePath = product.PicturePath;

            if (!string.IsNullOrWhiteSpace(currentPicturePath))
            {
                ReplacePreviewImage(LoadImage(currentPicturePath));
            }
        }

        private void ButtonAddPicture_Click(object sender, EventArgs e)
        {
            using (var dialog = new OpenFileDialog())
            {
                dialog.Filter = "Изображения|*.jpg;*.jpeg;*.png;*.bmp";
                dialog.Title = "Выберите изображение товара";

                if (dialog.ShowDialog(this) != DialogResult.OK)
                {
                    return;
                }

                selectedImageFilePath = dialog.FileName;
                ReplacePreviewImage(LoadImageFromAbsolutePath(selectedImageFilePath));
            }
        }

        private void ButtonSave_Click(object sender, EventArgs e)
        {
            try
            {
                var product = BuildProductModel();
                SaveProduct(product);
                DialogResult = DialogResult.OK;
                Close();
            }
            catch (InvalidOperationException exception)
            {
                DialogService.ShowWarning(exception.Message, "Проверьте данные");
            }
            catch (Exception exception)
            {
                DialogService.ShowException(exception, "сохранить товар");
            }
        }

        private ProductEditItem BuildProductModel()
        {
            var name = textBoxName.Text.Trim();
            if (string.IsNullOrWhiteSpace(name))
            {
                throw new InvalidOperationException("Введите наименование товара.");
            }

            return new ProductEditItem
            {
                Article = article,
                Name = name,
                CategoryId = GetSelectedLookupId(comboBoxCategory, "категории"),
                Description = textBoxDescription.Text.Trim(),
                ManufacturerId = GetSelectedLookupId(comboBoxManufacturer, "производителя"),
                ProviderId = GetSelectedLookupId(comboBoxProvider, "поставщика"),
                Cost = ParseNonNegativeInt(textBoxCost.Text, "цены"),
                MeasurementId = GetSelectedLookupId(comboBoxMeasurement, "единицы измерения"),
                Quantity = ParseNonNegativeInt(textBoxQuantity.Text, "количества"),
                Discount = ParseNonNegativeInt(textBoxDiscount.Text, "скидки"),
                PicturePath = SavePictureIfNeeded()
            };
        }

        private void SaveProduct(ProductEditItem product)
        {
            if (IsEditMode)
            {
                ProductService.UpdateProduct(product);

                if (!string.Equals(originalPicturePath, product.PicturePath, StringComparison.OrdinalIgnoreCase))
                {
                    ProductImageService.DeleteImage(originalPicturePath);
                }
            }
            else
            {
                ProductService.InsertProduct(product);
            }
        }

        private string SavePictureIfNeeded()
        {
            if (string.IsNullOrWhiteSpace(selectedImageFilePath))
            {
                return currentPicturePath;
            }

            currentPicturePath = ProductImageService.SaveImage(selectedImageFilePath);
            selectedImageFilePath = null;
            return currentPicturePath;
        }

        private void ReplacePreviewImage(Image image)
        {
            if (pictureBoxEditProduct.Image != null)
            {
                pictureBoxEditProduct.Image.Dispose();
            }

            pictureBoxEditProduct.Image = image;
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

        private static int ParseNonNegativeInt(string text, string fieldName)
        {
            int value;
            if (!int.TryParse(text.Trim(), out value))
            {
                throw new InvalidOperationException("Введите корректное число для " + fieldName + ".");
            }

            if (value < 0)
            {
                throw new InvalidOperationException("Значение " + fieldName + " не может быть отрицательным.");
            }

            return value;
        }

        private static Image LoadImage(string relativePath)
        {
            var resourceImage = AppResources.GetBitmapByReference(relativePath);
            if (resourceImage != null)
            {
                return new Bitmap(resourceImage);
            }

            if (string.IsNullOrWhiteSpace(relativePath))
            {
                return new Bitmap(AppResources.PicturePlaceholder);
            }

            return LoadImageFromAbsolutePath(Path.Combine(Application.StartupPath, relativePath));
        }

        private static Image LoadImageFromAbsolutePath(string fullPath)
        {
            if (!File.Exists(fullPath))
            {
                return new Bitmap(AppResources.PicturePlaceholder);
            }

            using (var image = Image.FromFile(fullPath))
            {
                return new Bitmap(image);
            }
        }
    }
}
