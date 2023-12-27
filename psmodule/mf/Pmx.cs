using System.Numerics;
using System.Runtime.InteropServices;
using System.Text;


namespace Pmx
{
    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct Magic
    {
        public byte _0;
        public byte _1;
        public byte _2;
        public byte _3;

        public override string ToString()
        {
            return $"{(char)_0}{(char)_1}{(char)_2}{(char)_3}";
        }
    }

    public enum TextEncoding : byte
    {
        Utf16,
        Utf8,
    }

    public enum IndexSize : byte
    {
        U8 = 1,
        U16 = 2,
        U32 = 4,
    }

    [StructLayout(LayoutKind.Sequential, Pack = 1)]
    public struct Header
    {
        public Magic Magic;
        public float Version;
        public byte FlagCount;
        public TextEncoding TextEncoding;
        public byte AdditionalUv;
        public IndexSize VertexIndexSize;
        public IndexSize TextureIndexSize;
        public IndexSize MaterialIndexSize;
        public IndexSize BoneIndexSize;
        public IndexSize MorphIndexSize;
        public IndexSize RigidBodyIndexSize;
    }

    public enum VertexBlending : byte
    {
        BDEF1,
        BDEF2,
        BDEF4,
        SDEF
    }

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

    public struct VertexGeometry
    {
        public Vector3 Position;
        public Vector3 Normal;
    }

    public ref struct Model
    {
        public string Name;
        public string NameEnglish;
        public string Comment;
        public string CommentEnglish;

        public ReadOnlySpan<VertexGeometry> VertexGeometries;
        public int IndexStride;
        public ReadOnlySpan<byte> Indices;
    }

    public class Loader
    {
        readonly DirectoryInfo _baseDir;

        public Loader(DirectoryInfo baseDir)
        {
            _baseDir = baseDir;
        }

        public static bool TryFromPath(string path, out Model model)
        {
            var file = new FileInfo(path);
            if (!file.Exists)
            {
                model = default;
                return false;
            }

            var data = File.ReadAllBytes(file.FullName);
            if (data == null)
            {
                model = default;
                return false;
            }

            var loader = new Loader(file.Directory!);
            model = loader.Load(data);
            return true;
        }

        Model Load(byte[] data)
        {
            var r = new Reader(data);

            var header = r.Get<Pmx.Header>();

            var name = r.GetText(header.TextEncoding);
            var nameEnglish = r.GetText(header.TextEncoding);
            var comment = r.GetText(header.TextEncoding);
            var commentEnglish = r.GetText(header.TextEncoding);

            var vertexCount = r.Get<int>();
            var vertexGeometries = new VertexGeometry[vertexCount];
            for (int i = 0; i < vertexCount; ++i)
            {
                var position = r.Get<Vector3>();
                var normal = r.Get<Vector3>();
                vertexGeometries[i] = new VertexGeometry
                {
                    Position = position,
                    Normal = normal,
                };
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

            return new Model
            {
                Name = name,
                NameEnglish = nameEnglish,
                Comment = comment,
                CommentEnglish = commentEnglish,
                VertexGeometries = vertexGeometries,
                IndexStride = (int)header.VertexIndexSize,
                Indices = indices,
            };
        }
    } // class
} // namespace