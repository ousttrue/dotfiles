using System.Text;


namespace Lbsm
{
  [System.Serializable]
  public class LbsmAxes
  {
    // string enum
    // "left/right", "up/down", "forward/back";
    public string x = "right";
    public string y = "up";
    public string z = "forward";
  }

  [System.Serializable]
  public class LbsmAsset
  {
    public string version = "alpha";
    public LbsmAxes axes = new LbsmAxes();

    public override string ToString()
    {
      return $"{{version: {version}}}";
    }
  }

  [System.Serializable]
  public class LbsmBufferView
  {
    public string name = "";
    public int byteOffset;
    public int byteLength;
    public override string ToString()
    {
      return $"{{name: {name}, byteOffset: {byteOffset}, byteLength: {byteLength}}}";
    }
  }

  [System.Serializable]
  public class LbsmAttribute
  {
    public string vertexAttribute = "";
    public string format = "";
    public int dimension;
  }

  [System.Serializable]
  public class LbsmStream
  {
    public string bufferView = "";
    public LbsmAttribute[] attributes = new LbsmAttribute[] { };
  }

  [System.Serializable]
  public class LbsmIndices
  {
    public int stride;
    public string bufferView = "";
  }

  [System.Serializable]
  public class LbsmTexture
  {
    public string bufferView;
  }

  [System.Serializable]
  public class LbsmMaterial
  {
    public string name = "";
    public float[] color = new float[] { 1, 1, 1, 1 };
    public int colorTexture;
  }

  [System.Serializable]
  public class LbsmSubMesh
  {
    public int material;
    public int drawCount;
  }

  [System.Serializable]
  public class LbsmMesh
  {
    public string name = "";
    public int vertexCount;
    public LbsmStream[] vertexStreams = new LbsmStream[] { };
    public LbsmIndices indices = new LbsmIndices { };
    public LbsmSubMesh[] subMeshes = new LbsmSubMesh[] { };
    public int[]? joints;
    public override string ToString()
    {
      return $"{{name: {name}, vertexStreams: {vertexStreams}, indices: {indices}, joints: {joints}}}";
    }
  }

  [System.Serializable]
  public class LbsmBone
  {
    public string name = "";
    public int parent;
    public float[] head = new float[] { };
    public float[] tail = new float[] { };
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

    public LbsmAsset asset = new LbsmAsset { };
    public LbsmBufferView[] bufferViews = new LbsmBufferView[] { };
    public LbsmTexture[] textures = new LbsmTexture[] { };
    public LbsmMaterial[] materials = new LbsmMaterial[] { };
    public LbsmMesh[] meshes = new LbsmMesh[] { };
    public LbsmBone[]? bones;

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
