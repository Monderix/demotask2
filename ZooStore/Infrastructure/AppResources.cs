using System.Drawing;
using System.IO;
using System.Resources;

namespace ZooStore.Infrastructure
{
    internal static class AppResources
    {
        private static readonly ResourceManager ResourceManager =
            new ResourceManager("ZooStore.Properties.Resources", typeof(AppResources).Assembly);

        public static Bitmap PicturePlaceholder
        {
            get { return GetBitmap("picture"); }
        }

        public static Bitmap GetBitmap(string name)
        {
            return ResourceManager.GetObject(name) as Bitmap;
        }

        public static Bitmap GetBitmapByReference(string reference)
        {
            if (string.IsNullOrWhiteSpace(reference))
            {
                return null;
            }

            var normalizedName = Path.GetFileNameWithoutExtension(reference.Trim());
            if (string.IsNullOrWhiteSpace(normalizedName))
            {
                return null;
            }

            return GetBitmap(normalizedName);
        }
    }
}
