using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;


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

      var lbsm = new Lbsm.LbsmRoot
      {
        asset = new Lbsm.LbsmAsset { version = "alpha" },
        bufferViews = bin.BufferViews.ToArray(),
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
      Console.WriteLine(jsonString);
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
