using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using ZooStore.Infrastructure;
using ZooStore.Models;

namespace ZooStore
{
    public partial class UserControlProduct : UserControl
    {
        private static readonly Color DiscountHighlightColor = ColorTranslator.FromHtml("#67D31D");
        private static readonly Color EmptyStockHighlightColor = ColorTranslator.FromHtml("#ADD8E6");
        private const string DefaultText = "Не указано";

        public event EventHandler EditRequested;
        public event EventHandler Selected;

        public UserControlProduct()
        {
            InitializeComponent();
            ConfigureLayout();
        }

        internal string ProductArticle { get; private set; }

        internal bool IsSelected
        {
            get { return BorderStyle == BorderStyle.FixedSingle; }
            set { BorderStyle = value ? BorderStyle.FixedSingle : BorderStyle.None; }
        }

        internal void Bind(ProductListItem product)
        {
            if (product == null)
            {
                throw new ArgumentNullException("product");
            }

            ProductArticle = product.Article;
            labelCategoryNameItem.Text = string.Format(
                "{0} | {1}",
                GetText(product.Category),
                GetText(product.Name));

            labelDescriptVal.Text = GetText(product.Description);
            labelManufacturerVal.Text = GetText(product.Manufacturer);
            labelProviderVal.Text = GetText(product.Provider);
            labelMeasVal.Text = GetText(product.Measurement);
            labelQuanVal.Text = product.Quantity.ToString();
            labelDiscount.Text = string.Format("{0}%", product.Discount);

            label3.Visible = false;
            labelDescriptonValue.Visible = false;
            labelManufacturerValue.Visible = false;
            labelProviderValue.Visible = false;
            labelMeasurementValue.Visible = false;
            labelQuantityValue.Visible = false;
            labelCostValue.Visible = false;

            ApplyPrice(product);
            ApplyColors(product);
            ApplyImage(product.PicturePath);
        }

        private void ConfigureLayout()
        {
            Margin = new Padding(8);
            pictureBoxProduct.SizeMode = PictureBoxSizeMode.Zoom;
            panelDiscount.BackColor = Color.WhiteSmoke;
            labelDiscount.TextAlign = ContentAlignment.MiddleCenter;
            BorderStyle = BorderStyle.None;
            HookDoubleClick(this);
            HookClick(this);
            Disposed += UserControlProduct_Disposed;
        }

        private void ApplyPrice(ProductListItem product)
        {
            if (product.HasDiscount)
            {
                labelCost.Text = "Старая цена:";
                labelPriceVal.ForeColor = Color.Firebrick;
                labelPriceVal.Font = new Font(labelPriceVal.Font, FontStyle.Strikeout);
                labelPriceVal.Text = string.Format("{0} руб.", product.Cost);
                labelFinalPrice.Visible = true;
                labelFinalPrice.Text = string.Format("Новая цена: {0:0.##} руб.", product.FinalPrice);
            }
            else
            {
                labelCost.Text = "Цена:";
                labelPriceVal.ForeColor = Color.Black;
                labelPriceVal.Font = new Font(labelPriceVal.Font, FontStyle.Regular);
                labelPriceVal.Text = string.Format("{0} руб.", product.Cost);
                labelFinalPrice.Visible = false;
            }
        }

        private void ApplyColors(ProductListItem product)
        {
            var discountBackgroundColor = product.Discount > 15 ? DiscountHighlightColor : Color.WhiteSmoke;
            var quantityBackgroundColor = product.Quantity == 0 ? EmptyStockHighlightColor : Color.Transparent;

            BackColor = Color.White;
            panelInformationProduct.BackColor = Color.White;
            panelDiscount.BackColor = discountBackgroundColor;
            labelQuanVal.BackColor = quantityBackgroundColor;
        }

        private void ApplyImage(string relativePath)
        {
            ClearImage();
            pictureBoxProduct.Image = LoadProductImage(relativePath);
        }

        private void HookDoubleClick(Control control)
        {
            control.DoubleClick += Control_DoubleClick;

            foreach (Control child in control.Controls)
            {
                HookDoubleClick(child);
            }
        }

        private void HookClick(Control control)
        {
            control.Click += Control_Click;

            foreach (Control child in control.Controls)
            {
                HookClick(child);
            }
        }

        private void Control_DoubleClick(object sender, EventArgs e)
        {
            if (EditRequested != null)
            {
                EditRequested(this, EventArgs.Empty);
            }
        }

        private void Control_Click(object sender, EventArgs e)
        {
            if (Selected != null)
            {
                Selected(this, EventArgs.Empty);
            }
        }

        private void UserControlProduct_Disposed(object sender, EventArgs e)
        {
            ClearImage();
        }

        private void ClearImage()
        {
            if (pictureBoxProduct.Image == null)
            {
                return;
            }

            pictureBoxProduct.Image.Dispose();
            pictureBoxProduct.Image = null;
        }

        private static Image LoadProductImage(string relativePath)
        {
            var resourceImage = AppResources.GetBitmapByReference(relativePath);
            if (resourceImage != null)
            {
                return new Bitmap(resourceImage);
            }

            var fullPath = string.IsNullOrWhiteSpace(relativePath)
                ? string.Empty
                : Path.Combine(Application.StartupPath, relativePath);

            if (!string.IsNullOrWhiteSpace(fullPath) && File.Exists(fullPath))
            {
                using (var source = Image.FromFile(fullPath))
                {
                    return new Bitmap(source);
                }
            }

            return new Bitmap(AppResources.PicturePlaceholder);
        }

        private static string GetText(string value)
        {
            return string.IsNullOrWhiteSpace(value) ? DefaultText : value.Trim();
        }

        private void labelQuanVal_Click(object sender, EventArgs e)
        {
        }

        private void labelFinalPrice_Click(object sender, EventArgs e)
        {
        }
    }
}
