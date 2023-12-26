using System.Diagnostics;
using System.Numerics;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;
using Pmx;

namespace mf
{
  class Reader
  {
    byte[] _array;
    int _pos;

    public Reader(byte[] array)
    {
      _array = array;
      _pos = 0;
    }

    public ArraySegment<byte> GetBytes(int size)
    {
      var span = new ArraySegment<byte>(this._array, this._pos, size);
      this._pos += size;
      return span;
    }

    public ref T Get<T>()
            where T : struct
    {
      var span = GetBytes(Marshal.SizeOf<T>());
      return ref MemoryMarshal.Cast<byte, T>(span)[0];
    }

    public string GetText(Pmx.TextEncoding encoding)
    {
      var value = Get<int>();
      var span = GetBytes(value);
      switch (encoding)
      {
        case Pmx.TextEncoding.Utf8: return Encoding.UTF8.GetString(span);
        case Pmx.TextEncoding.Utf16: return Encoding.Unicode.GetString(span);
      }
      throw new ArgumentException();
    }

    public Int32 Index(Pmx.IndexSize size)
    {
      switch (size)
      {
        case IndexSize.U8:
          return Get<byte>();
        case IndexSize.U16:
          return Get<ushort>();
        case IndexSize.U32:
          return Get<int>();
      }
      throw new ArgumentException();
    }
  }

  struct VertexGeometry
  {
    public Vector3 Position;
    public Vector3 Normal;
  }

  class Bin
  {
    List<byte> _bytes = new List<byte>();
    public ReadOnlySpan<byte> Bytes => CollectionsMarshal.AsSpan(_bytes);

    List<Lbsm.LbsmBufferView> _views = new List<Lbsm.LbsmBufferView>();
    public IReadOnlyCollection<Lbsm.LbsmBufferView> BufferViews => _views;

    public void Push(string name, ReadOnlySpan<byte> span)
    {
      _views.Add(new Lbsm.LbsmBufferView
      {
        name = name,
        byteOffset = _bytes.Count,
        byteLength = span.Length,
      });
      _bytes.AddRange(span);
    }
  }

  class Cli
  {
    static void Main(string[] args)
    {
      var data = File.ReadAllBytes(args[0]);
      if (data == null)
      {
        return;
      }

      var r = new Reader(data);

      var header = r.Get<Pmx.Header>();
      Debug.WriteLine(header);

      var name = r.GetText(header.TextEncoding);
      var nameEngliesh = r.GetText(header.TextEncoding);
      var comment = r.GetText(header.TextEncoding);
      var commentEnglish = r.GetText(header.TextEncoding);
      Debug.WriteLine(name);
      Debug.WriteLine(nameEngliesh);
      Debug.WriteLine(comment);
      Debug.WriteLine(commentEnglish);

      var vertexCount = r.Get<int>();
      var vertexGeometry = new List<VertexGeometry>(vertexCount);
      for (int i = 0; i < vertexCount; ++i)
      {
        var position = r.Get<Vector3>();
        var normal = r.Get<Vector3>();
        vertexGeometry.Add(new VertexGeometry
        {
          Position = position,
          Normal = normal,
        });
        var uv = r.Get<Vector2>()[0];
        for (int j = 0; j < header.AdditionalUv; ++j)
        {
          var add_uv = r.Get<Vector4>()[0];
        }
        var blending = (Pmx.VertexBlending)r.Get<byte>();
        switch (blending)
        {
          case Pmx.VertexBlending.BDEF1:
            {
              var bone = r.Index(header.BoneIndexSize);
            }
            break;
          case Pmx.VertexBlending.BDEF2:
            {
              var bone0 = r.Index(header.BoneIndexSize);
              var bone1 = r.Index(header.BoneIndexSize);
              var weight = r.Get<float>();
            }
            break;
          case Pmx.VertexBlending.BDEF4:
            {
              var bone0 = r.Index(header.BoneIndexSize);
              var bone1 = r.Index(header.BoneIndexSize);
              var bone2 = r.Index(header.BoneIndexSize);
              var bone3 = r.Index(header.BoneIndexSize);
              var weight = r.Get<Vector4>();
            }
            break;
          case Pmx.VertexBlending.SDEF:
            {
              var bone0 = r.Index(header.BoneIndexSize);
              var bone1 = r.Index(header.BoneIndexSize);
              var weight = r.Get<float>();
              r.Get<Vector3>();
              r.Get<Vector3>();
              r.Get<Vector3>();
            }
            break;
        }
        var edgeFactr = r.Get<float>();
      }
      int indexCount = r.Get<int>();
      var indices = r.GetBytes(indexCount * (int)header.VertexIndexSize);

      var bin = new Bin();
      bin.Push("indx", indices);
      bin.Push("geom", MemoryMarshal.Cast<VertexGeometry, byte>(CollectionsMarshal.AsSpan(vertexGeometry)));

      var lbsm = new Lbsm.LbsmRoot
      {
        asset = new Lbsm.LbsmAsset { version = "alpha" },
        bufferViews = bin.BufferViews.ToArray(),
        meshes = new Lbsm.LbsmMesh[] {
          new Lbsm.LbsmMesh{
              name=name,
              vertexCount=vertexCount,
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
                }
              },
              indices =new Lbsm.LbsmIndices{
                bufferView="indx",
                stride=(int)header.VertexIndexSize,
              },
          },
        },
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
