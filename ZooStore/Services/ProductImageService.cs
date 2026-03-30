using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Windows.Forms;

namespace ZooStore.Services
{
    internal static class ProductImageService
    {
        private const int TargetWidth = 300;
        private const int TargetHeight = 200;
        private const string ImagesFolder = "Images\\Products";

        public static string SaveImage(string sourceFilePath)
        {
            var imagesDirectory = Path.Combine(Application.StartupPath, ImagesFolder);
            Directory.CreateDirectory(imagesDirectory);

            var fileName = Guid.NewGuid().ToString("N") + ".jpg";
            var destinationFullPath = Path.Combine(imagesDirectory, fileName);

            using (var sourceImage = Image.FromFile(sourceFilePath))
            using (var resizedImage = Resize(sourceImage))
            {
                resizedImage.Save(destinationFullPath, ImageFormat.Jpeg);
            }

            return Path.Combine(ImagesFolder, fileName);
        }

        public static void DeleteImage(string relativePath)
        {
            if (string.IsNullOrWhiteSpace(relativePath))
            {
                return;
            }

            var fullPath = Path.Combine(Application.StartupPath, relativePath);
            if (File.Exists(fullPath))
            {
                File.Delete(fullPath);
            }
        }

        private static Bitmap Resize(Image sourceImage)
        {
            var bitmap = new Bitmap(TargetWidth, TargetHeight);

            using (var graphics = Graphics.FromImage(bitmap))
            {
                graphics.Clear(Color.White);
                graphics.CompositingQuality = CompositingQuality.HighQuality;
                graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphics.SmoothingMode = SmoothingMode.HighQuality;

                var ratio = Math.Min((float)TargetWidth / sourceImage.Width, (float)TargetHeight / sourceImage.Height);
                var width = (int)(sourceImage.Width * ratio);
                var height = (int)(sourceImage.Height * ratio);
                var x = (TargetWidth - width) / 2;
                var y = (TargetHeight - height) / 2;

                graphics.DrawImage(sourceImage, x, y, width, height);
            }

            return bitmap;
        }
    }
}
