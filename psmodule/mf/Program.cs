using System.Drawing;
using System.Numerics;
using System.Runtime.InteropServices;
using System.Text;
using System.Text.Json;
using Lbsm;


namespace mf
{
  static class LbsmExporter
  {
    public static (LbsmRoot, List<byte>) Export(Pmx.Model pmx, string baseDir)
    {
      var bin = new Bin();

      //
      // create texture bytes
      //
      for (int i = 0; i < pmx.Textures.Length; ++i)
      {
        var textureName = pmx.Textures[i];
        var texturePath = Path.Join(baseDir, textureName);
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
            ImageUtil.TgaToPng(texturePath, (png) =>
            {
              bin.Push<byte>(textureName.Substring(0, textureName.Length - 4) + ".png", png);
            });
            break;

          case ".bmp":
            ImageUtil.BmpToPng(texturePath, (png) =>
            {
              bin.Push<byte>(textureName.Substring(0, textureName.Length - 4) + ".png", png);
            });
            break;

          default:
            throw new NotImplementedException(ext);
        }
      }

      //
      // vertex & index bytes
      //
      var geom = bin.Push("geom", pmx.VertexGeometries);
      var txuv = bin.Push("txuv", pmx.VertexTextures);
      var skin = bin.Push("skin", pmx.VertexSkins);
      var indx = bin.Push("indx", pmx.Indices);
      var morphTargets = pmx.VertexPositionMoprhs.Select((x) =>
      {
        var indx = bin.Push<byte>($"morph:{x.Name}.indx", x.Indices);
        var pos = bin.Push<Vector3>($"morph:{x.Name}.pos", x.Positions);
        return new LbsmMorphTarget
        {
          name = x.Name,
          indexBufferView = indx,
          positionBufferView = pos,
        };
      }).ToArray();

      //
      // lbsm struct
      //
      var textures = pmx.Textures;
      var lbsm = new Lbsm.LbsmRoot(
        new Lbsm.LbsmAsset
        {
          version = "alpha",
          coordinates = Lbsm.LbsmCoordinates.Unity,
        },
        bin.BufferViews.ToArray(),
        pmx.Textures.Select((x, i) => new LbsmTexture
        {
          bufferView = i,
        }).ToArray(),
        pmx.Materials.Select(x => new LbsmMaterial
        {
          name = x.Name,
          color = new float[4] { x.ColorRGBA.X, x.ColorRGBA.Y, x.ColorRGBA.Z, x.ColorRGBA.W },
          colorTexture = x.ColorTexture,
        }).ToArray(),
        new Lbsm.LbsmMesh[] {
          new Lbsm.LbsmMesh{
              name=pmx.Name,
              vertexCount=pmx.VertexGeometries.Length,
              vertexStreams=new Lbsm.LbsmStream[]{
                new Lbsm.LbsmStream{
                  bufferView = geom,
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
                  bufferView = txuv,
                  attributes = new Lbsm.LbsmAttribute[]{
                    new Lbsm.LbsmAttribute{
                      vertexAttribute="tex0",
                      format="f32",
                      dimension=2,
                    },
                  },
                },
                new Lbsm.LbsmStream{
                  bufferView = skin,
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
                bufferView=indx,
                stride=(int)pmx.IndexStride,
              },
              subMeshes = pmx.Materials.Select((x, i) =>new LbsmSubMesh{
                material=i,
                drawCount=x.DrawCount,
              }).ToArray(),
              morphTargets = morphTargets,
              joints = pmx.Bones.Select((_, i)=>i).ToArray(),
          },
        },
        pmx.Bones.Select(x => new Lbsm.LbsmBone
        {
          name = x.Name,
          head = new float[] { x.Position.X, x.Position.Y, x.Position.Z },
          parent = x.Parent.GetValueOrDefault(ushort.MaxValue),
        }).ToArray()
      );

      return (lbsm, bin.Bytes);
    }

    public static void Write(string path, LbsmRoot lbsm, Span<byte> binChunk)
    {
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
      var totalSize = 12 + (8 + jsonChunk.Length) + (8 + binChunk.Length);

      using (var w = new FileStream(path, FileMode.Create))
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

  class Cli
  {
    static void Main(string[] args)
    {
      if (args.Length != 2)
      {
        throw new ArgumentNullException("usage: {from} {to}");
      }

      if (!Pmx.Loader.TryFromPath(args[0], out var pmx))
      {
        throw new Exception($"fail to load: {args[0]}");
      }

      var (lbsm, bin) = LbsmExporter.Export(pmx, Path.GetDirectoryName(args[0])!);
      LbsmExporter.Write(args[1], lbsm, CollectionsMarshal.AsSpan(bin));
    }
  }
}