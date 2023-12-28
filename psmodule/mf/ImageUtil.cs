using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
using Pfim;

namespace mf
{
    public static class ImageUtil
    {
        public static void BmpToPng(string texturePath, Action<byte[]> callback)
        {
            using (var bitmap = new Bitmap(texturePath))
            {
                using (var ms = new MemoryStream())
                {
                    bitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    callback(ms.ToArray());
                }
            }
        }

        public static void TgaToPng(string texturePath, Action<byte[]> callback)
        {
            using (var image = Pfimage.FromFile(texturePath))
            {
                PixelFormat format;

                // Convert from Pfim's backend agnostic image format into GDI+'s image format
                switch (image.Format)
                {
                    case Pfim.ImageFormat.Rgba32:
                        format = PixelFormat.Format32bppArgb;
                        break;

                    case Pfim.ImageFormat.Rgb24:
                        format = PixelFormat.Format24bppRgb;
                        break;

                    default:
                        // see the sample for more details
                        throw new NotImplementedException();
                }
                // Pin pfim's data array so that it doesn't get reaped by GC, unnecessary
                // in this snippet but useful technique if the data was going to be used in
                // control like a picture box
                var handle = GCHandle.Alloc(image.Data, GCHandleType.Pinned);
                try
                {
                    var data = Marshal.UnsafeAddrOfPinnedArrayElement(image.Data, 0);
                    using (var bitmap = new Bitmap(image.Width, image.Height, image.Stride, format, data))
                    {
                        using (var ms = new MemoryStream())
                        {
                            bitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                            callback(ms.ToArray());
                        }
                    }
                }
                finally
                {
                    handle.Free();
                }
            }
        }
    }
}

