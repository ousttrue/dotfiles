using System.Drawing;
using System.Drawing.Imaging;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;
using Lbsm;
using Pfim;


namespace mf
{
  class Bin
  {
    List<byte> _bytes = new List<byte>();
    public ReadOnlySpan<byte> Bytes => CollectionsMarshal.AsSpan(_bytes);

    List<Lbsm.LbsmBufferView> _views = new List<Lbsm.LbsmBufferView>();
    public IReadOnlyCollection<Lbsm.LbsmBufferView> BufferViews => _views;

    public void Push<T>(string name, ReadOnlySpan<T> span) where T : struct
    {
      var bytes = MemoryMarshal.Cast<T, byte>(span);
      _views.Add(new Lbsm.LbsmBufferView
      {
        name = name,
        byteOffset = _bytes.Count,
        byteLength = bytes.Length,
      });
      _bytes.AddRange(bytes);
    }
  }

  class Cli
  {
    static void Main(string[] args)
    {
      if (args.Length == 0)
      {
        throw new ArgumentNullException();
      }

      if (!Pmx.Loader.TryFromPath(args[0], out var pmx))
      {
        throw new Exception($"fail to load: {args[0]}");
      }

      var bin = new Bin();
      bin.Push("geom", pmx.VertexGeometries);
      bin.Push("txuv", pmx.VertexTextures);
      bin.Push("skin", pmx.VertexSkins);
      bin.Push("indx", pmx.Indices);

      for (int i = 0; i < pmx.Textures.Length; ++i)
      {
        var textureName = pmx.Textures[i];
        var texturePath = Path.Join(Path.GetDirectoryName(args[0]), textureName);
        var ext = Path.GetExtension(textureName).ToLower();
        switch (ext)
        {
          case ".png":
          case ".jpg":
            {
              var textureBytes = File.ReadAllBytes(texturePath);
              if (textureBytes != null)
              {
                bin.Push<byte>(textureName, textureBytes);
              }
              else
              {
                throw new FileNotFoundException(textureName);
              }
            }
            break;

          case ".tga":
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
                      bin.Push<byte>(textureName, ms.ToArray());
                    }
                  }
                  // pmx.Textures[i] = Path.GetFileNameWithoutExtension(textureName) + ".png";
                }
                finally
                {
                  handle.Free();
                }
              }
            }
            break;

          case ".bmp":
            {
              using (var bitmap = new Bitmap(texturePath))
              {
                using (var ms = new MemoryStream())
                {
                  bitmap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                  bin.Push<byte>(textureName, ms.ToArray());
                }
              }
              // pmx.Textures[i] = Path.GetFileNameWithoutExtension(textureName) + ".png";
            }
            break;

          default:
            throw new NotImplementedException(ext);
        }
      }

      var textures = pmx.Textures;
      var lbsm = new Lbsm.LbsmRoot
      {
        asset = new Lbsm.LbsmAsset
        {
          version = "alpha",
          axes = new Lbsm.LbsmAxes
          {
            x = "right",
            y = "up",
            z = "forward",
          },
        },
        bufferViews = bin.BufferViews.ToArray(),
        textures = pmx.Textures.Select(x => new LbsmTexture
        {
          bufferView = x,
        }).ToArray(),
        materials = pmx.Materials.Select(x => new LbsmMaterial
        {
          name = x.Name,
          color = new float[4] { x.ColorRGBA.X, x.ColorRGBA.Y, x.ColorRGBA.Z, x.ColorRGBA.W },
          colorTexture = x.ColorTexture,
        }).ToArray(),
        meshes = new Lbsm.LbsmMesh[] {
          new Lbsm.LbsmMesh{
              name=pmx.Name,
              vertexCount=pmx.VertexGeometries.Length,
              vertexStreams=new Lbsm.LbsmStream[]{
                new Lbsm.LbsmStream{
                  bufferView = "geom",
                  attributes = new Lbsm.LbsmAttribute[]{
                    new Lbsm.LbsmAttribute{
                      vertexAttribute="position",
                      format="f32",
                      dimension=3,
                    },
                    new Lbsm.LbsmAttribute{
                      vertexAttribute="normal",
                      format="f32",
                      dimension=3,
                    },
                  },
                },
                new Lbsm.LbsmStream{
                  bufferView = "txuv",
                  attributes = new Lbsm.LbsmAttribute[]{
                    new Lbsm.LbsmAttribute{
                      vertexAttribute="tex0",
                      format="f32",
                      dimension=2,
                    },
                  },
                },
                new Lbsm.LbsmStream{
                  bufferView = "skin",
                  attributes = new Lbsm.LbsmAttribute[]{
                    new Lbsm.LbsmAttribute{
                      vertexAttribute="blendWeights",
                      format="f32",
                      dimension=4,
                    },
                    new Lbsm.LbsmAttribute{
                      vertexAttribute="blendIndices",
                      format="u16",
                      dimension=4,
                    },
                  },
                },
              },
              indices =new Lbsm.LbsmIndices{
                bufferView="indx",
                stride=(int)pmx.IndexStride,
              },
              subMeshes = pmx.Materials.Select((x, i) =>new LbsmSubMesh{
                material=i,
                drawCount=x.DrawCount,
              }).ToArray(),
              joints = pmx.Bones.Select((_, i)=>i).ToArray(),
          },
        },
        bones = pmx.Bones.Select(x => new Lbsm.LbsmBone
        {
          name = x.Name,
          head = new float[] { x.Position.X, x.Position.Y, x.Position.Z },
          parent = x.Parent.GetValueOrDefault(ushort.MaxValue),
        }).ToArray()
      };

      var option = new JsonSerializerOptions
      {
        IncludeFields = true,
      };
      var jsonString = JsonSerializer.Serialize(lbsm, option);
      Console.WriteLine(JsonSerializer.Serialize(lbsm, new JsonSerializerOptions
      {
        IncludeFields = true,
        WriteIndented = true,
      }));
      var jsonChunk = new UTF8Encoding(false).GetBytes(jsonString);
      var binChunk = bin.Bytes;
      var totalSize = 12 + (8 + jsonChunk.Length) + (8 + binChunk.Length);

      using (var w = new FileStream("tmp.bytes", FileMode.Create))
      using (var ww = new BinaryWriter(w))
      {
        var magic = new byte[] { (byte)'L', (byte)'B', (byte)'S', (byte)'M' };
        var jsonType = new byte[] { (byte)'J', (byte)'S', (byte)'O', (byte)'N' };
        var binType = new byte[] { (byte)'B', (byte)'I', (byte)'N', 0 };

        ww.Write(magic);
        ww.Write(1.0f);
        ww.Write(totalSize);
        // json
        ww.Write(jsonChunk.Length);
        ww.Write(jsonType);
        ww.Write(jsonChunk);
        // bin
        ww.Write(binChunk.Length);
        ww.Write(binType);
        ww.Write(binChunk);
      }
    }
  }
}
