using System.Text;


namespace Lbsm
{
  [System.Serializable]
  public struct LbsmAxes
  {
    // string enum
    // "left/right", "up/down", "forward/back";
    public string x;
    public string y;
    public string z;
  }

  [System.Serializable]
  public struct LbsmAsset
  {
    public string version;
    public LbsmAxes axes;

    public override string ToString()
    {
      return $"{{version: {version}}}";
    }
  }

  [System.Serializable]
  public struct LbsmBufferView
  {
    public string name;
    public int byteOffset;
    public int byteLength;
    public override string ToString()
    {
      return $"{{name: {name}, byteOffset: {byteOffset}, byteLength: {byteLength}}}";
    }
  }

  [System.Serializable]
  public struct LbsmAttribute
  {
    public string vertexAttribute;
    public string format;
    public int dimension;
  }

  [System.Serializable]
  public struct LbsmStream
  {
    public int bufferView;
    public LbsmAttribute[] attributes;
  }

  [System.Serializable]
  public class LbsmIndices
  {
    public int stride;
    public int bufferView;
  }

  [System.Serializable]
  public class LbsmTexture
  {
    public int bufferView;
  }

  [System.Serializable]
  public struct LbsmMaterial
  {
    public string name;
    public float[] color;
    public int colorTexture;
  }

  [System.Serializable]
  public struct LbsmSubMesh
  {
    public int material;
    public int drawCount;
  }

  [System.Serializable]
  public struct LbsmMorphTarget
  {
    public string Name;
    public int indexStride;
    public int indexBufferView;
    public int positionBufferView;
    public LbsmMorphTarget(string name)
    {
      Name = name;
    }
  }

  [System.Serializable]
  public struct LbsmMesh
  {
    public string name;
    public int vertexCount;
    public LbsmStream[] vertexStreams;
    public LbsmIndices indices;
    public LbsmSubMesh[] subMeshes;
    public LbsmMorphTarget[] morphTargets;
    public int[] joints;
    public override string ToString()
    {
      return $"{{name: {name}, vertexStreams: {vertexStreams}, indices: {indices}, joints: {joints}}}";
    }
  }

  [System.Serializable]
  public struct LbsmBone
  {
    public string name;
    public int parent;
    public float[] head;
    public float[] tail;
    public bool isConnected;
    public override string ToString()
    {
      return $"{name}({head[0]}, {head[1]}, {head[2]})";
    }
  }

  [System.Serializable]
  public class LbsmRoot
  {
    public static readonly byte[] MAGIC = new ASCIIEncoding().GetBytes("LBSM");
    public static string ParseChunkType(Span<byte> bytes)
    {
      var end = 0;
      for (; end < bytes.Length; ++end)
      {
        if (bytes[end] == 0)
        {
          break;
        }
      }
      return new ASCIIEncoding().GetString(bytes.Slice(0, end));
    }

    public LbsmAsset asset;
    public LbsmBufferView[] bufferViews;
    public LbsmTexture[] textures;
    public LbsmMaterial[] materials;
    public LbsmMesh[] meshes;
    public LbsmBone[] bones;

    public LbsmRoot(
      LbsmAsset asset,
      LbsmBufferView[] bufferViews,
      LbsmTexture[] textures,
      LbsmMaterial[] materials,
      LbsmMesh[] meshes,
      LbsmBone[] bones)
    {
      this.asset = asset;
      this.bufferViews = bufferViews;
      this.textures = textures;
      this.materials = materials;
      this.meshes = meshes;
      this.bones = bones;
    }

    public override string ToString()
    {
      var sb = new StringBuilder();

      sb.AppendLine("{");
      sb.AppendLine($"  asset: {asset},");
      sb.AppendLine("  bufferViews:[");

      foreach (var b in bufferViews)
      {
        sb.Append("    ");
        sb.Append(b);
        sb.AppendLine(",");
      }
      sb.AppendLine("  ],");
      sb.AppendLine("  meshes: [");
      foreach (var m in meshes)
      {
        sb.Append("    ");
        sb.Append(m);
        sb.AppendLine(",");
      }
      sb.AppendLine("  ]");
      sb.AppendLine("}");
      return sb.ToString();
    }
  }
}
