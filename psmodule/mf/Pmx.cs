using System.ComponentModel;
using System.Diagnostics;
using System.Numerics;
using System.Runtime.InteropServices;
using System.Text;
using Lbsm;


namespace Pmx
{
    static class Vector3Extension
    {
        public static Vector3 TurnY180(this Vector3 v)
        {
            return new Vector3(-v.X, v.Y, -v.Z);
        }
    }

    static class Vector2Extension
    {
        public static Vector2 VerticalFlip(this Vector2 v)
        {
            return new Vector2(v.X, 1.0f - v.Y);
        }
    }

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
        I32 = 4,
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

        public string PmxText(Pmx.TextEncoding encoding)
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

        public Int32 PmxIndex(Pmx.IndexSize size)
        {
            switch (size)
            {
                case IndexSize.U8:
                    {
                        var i = Get<byte>();
                        if (i == byte.MaxValue)
                        {
                            return -1;
                        }
                        return i;
                    }
                case IndexSize.U16:
                    {
                        var i = Get<ushort>();
                        if (i == ushort.MaxValue)
                        {
                            return -1;
                        }
                        return i;
                    }
                case IndexSize.I32:
                    {
                        return Get<int>();
                    }
            }
            throw new ArgumentException();
        }
    }

    public struct VertexGeometry
    {
        public Vector3 Position;
        public Vector3 Normal;
    }

    public struct VertexTex
    {
        public Vector2 Texture0;
    }

    public struct UShort4
    {
        public ushort X;
        public ushort Y;
        public ushort Z;
        public ushort W;

        public UShort4(ushort x, ushort y, ushort z, ushort w)
        {
            X = x;
            Y = y;
            Z = z;
            W = w;
        }
    }

    public struct VertexSkin
    {
        public Vector4 Weights;
        public UShort4 Joints;

        public void Validate()
        {
            var total = 0.0f;
            if (Weights.X == 0 || Joints.X == ushort.MaxValue)
            {
                // clear
                Weights.X = 0;
                Joints.X = 0;
            }
            else
            {
                total += Weights.X;
            }

            if (Weights.Y == 0 || Joints.Y == ushort.MaxValue)
            {
                // clear
                Weights.Y = 0;
                Joints.Y = 0;
            }
            else
            {
                total += Weights.Y;
            }

            if (Weights.Z == 0 || Joints.Z == ushort.MaxValue)
            {
                // clear
                Weights.Z = 0;
                Joints.Z = 0;
            }
            else
            {
                total += Weights.Z;
            }

            if (Weights.W == 0 || Joints.W == ushort.MaxValue)
            {
                // clear
                Weights.W = 0;
                Joints.W = 0;
            }
            else
            {
                total += Weights.W;
            }

            if (total > 0)
            {
                Weights *= (1.0f / total);
            }
        }
    }

    public class Material
    {
        public string Name = "";
        public Vector4 ColorRGBA;
        public int ColorTexture;
        public int DrawCount;
    }

    [Flags]
    public enum BoneFlags : ushort
    {
        HasTail = 0x0001, //  : 接続先(PMD子ボーン指定)表示方法 -> 0:座標オフセットで指定 1:ボーンで指定
        EnableRotation = 0x0002,
        EnableTranslation = 0x0004,
        Visible = 0x0008,
        Editable = 0x0010,
        HasIk = 0x0020,
        LocalConstraint = 0x0080, // ローカル付与 | 付与対象 0:ユーザー変形値／IKリンク／多重付与 1:親のローカル変形量
        RotationConstraint = 0x0100,
        TranslationConstraint = 0x0200,
        FixedAxis = 0x0400,
        LocalAxis = 0x0800,
        AfterPhysics = 0x1000,
        ExternalParent = 0x2000,
    }

    public struct Bone
    {
        public string Name;
        public Vector3 Position;
        public int? Parent;
    }

    public ref struct Model
    {
        public string Name;
        public string NameEnglish;
        public string Comment;
        public string CommentEnglish;

        public ReadOnlySpan<VertexGeometry> VertexGeometries;
        public ReadOnlySpan<VertexTex> VertexTextures;
        public ReadOnlySpan<VertexSkin> VertexSkins;
        public int IndexStride;
        public ReadOnlySpan<byte> Indices;
        public string[] Textures;
        public Material[] Materials;
        public Bone[] Bones;
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
            const float scaling = 1.58f / 40.0f;

            var r = new Reader(data);

            var header = r.Get<Pmx.Header>();

            var name = r.PmxText(header.TextEncoding);
            var nameEnglish = r.PmxText(header.TextEncoding);
            var comment = r.PmxText(header.TextEncoding);
            var commentEnglish = r.PmxText(header.TextEncoding);

            var vertexCount = r.Get<int>();
            var vertexGeometries = new VertexGeometry[vertexCount];
            var vertexTextures = new VertexTex[vertexCount];
            var vertexSkins = new VertexSkin[vertexCount];
            for (int i = 0; i < vertexCount; ++i)
            {
                var position = r.Get<Vector3>();
                var normal = r.Get<Vector3>();
                vertexGeometries[i].Position = position.TurnY180() * scaling;
                vertexGeometries[i].Normal = normal.TurnY180();
                vertexTextures[i].Texture0 = r.Get<Vector2>().VerticalFlip();

                for (int j = 0; j < header.AdditionalUv; ++j)
                {
                    var add_uv = r.Get<Vector4>()[0];
                }

                var blending = (Pmx.VertexBlending)r.Get<byte>();
                switch (blending)
                {
                    case Pmx.VertexBlending.BDEF1:
                        {
                            var bone = r.PmxIndex(header.BoneIndexSize);
                            vertexSkins[i] = new VertexSkin
                            {
                                Joints = new UShort4((ushort)bone, ushort.MaxValue, ushort.MaxValue, ushort.MaxValue),
                                Weights = new Vector4(1, 0, 0, 0),
                            };
                        }
                        break;
                    case Pmx.VertexBlending.BDEF2:
                        {
                            var bone0 = r.PmxIndex(header.BoneIndexSize);
                            var bone1 = r.PmxIndex(header.BoneIndexSize);
                            var weight = r.Get<float>();
                            vertexSkins[i] = new VertexSkin
                            {
                                Joints = new UShort4((ushort)bone0, (ushort)bone1, ushort.MaxValue, ushort.MaxValue),
                                Weights = new Vector4(weight, 1.0f - weight, 0, 0),
                            };
                        }
                        break;
                    case Pmx.VertexBlending.BDEF4:
                        {
                            var bone0 = r.PmxIndex(header.BoneIndexSize);
                            var bone1 = r.PmxIndex(header.BoneIndexSize);
                            var bone2 = r.PmxIndex(header.BoneIndexSize);
                            var bone3 = r.PmxIndex(header.BoneIndexSize);
                            var weight = r.Get<Vector4>();
                            vertexSkins[i] = new VertexSkin
                            {
                                Joints = new UShort4((ushort)bone0, (ushort)bone1, (ushort)bone2, (ushort)bone3),
                                Weights = weight,
                            };
                        }
                        break;
                    case Pmx.VertexBlending.SDEF:
                        {
                            var bone0 = r.PmxIndex(header.BoneIndexSize);
                            var bone1 = r.PmxIndex(header.BoneIndexSize);
                            var weight = r.Get<float>();
                            r.Get<Vector3>();
                            r.Get<Vector3>();
                            r.Get<Vector3>();
                            vertexSkins[i] = new VertexSkin
                            {
                                Joints = new UShort4((ushort)bone0, (ushort)bone1, ushort.MaxValue, ushort.MaxValue),
                                Weights = new Vector4(weight, 1.0f - weight, 0, 0),
                            };
                        }
                        break;
                }
                vertexSkins[i].Validate();
                var edgeFactr = r.Get<float>();
            }
            int indexCount = r.Get<int>();
            var indices = r.GetBytes(indexCount * (int)header.VertexIndexSize);

            int textureCount = r.Get<int>();
            var textures = new string[textureCount];
            for (int i = 0; i < textureCount; ++i)
            {
                textures[i] = r.PmxText(header.TextEncoding);
            }

            int materialCount = r.Get<int>();
            var materials = new Material[materialCount];
            for (int i = 0; i < materialCount; ++i)
            {
                var materialName = r.PmxText(header.TextEncoding);
                var materialNameEnglish = r.PmxText(header.TextEncoding);
                var diffuseRGBA = r.Get<Vector4>();
                var specularRGB = r.Get<Vector3>();
                var specularFactor = r.Get<float>();
                var emissionRGB = r.Get<Vector3>();
                var materialFlags = r.Get<byte>();
                var edgeRGBA = r.Get<Vector4>();
                var edgeWidth = r.Get<float>();
                var colorTexture = r.PmxIndex(header.TextureIndexSize);
                var matcapTexture = r.PmxIndex(header.TextureIndexSize);
                var textureFlag = r.Get<byte>();
                var toonFlag = r.Get<byte>();
                if (toonFlag == 0)
                {
                    var toonTexture = r.PmxIndex(header.TextureIndexSize);
                }
                else
                {
                    var sharedToonTexture = r.Get<byte>();
                }
                var materialComment = r.PmxText(header.TextEncoding);
                var drawCount = r.Get<int>();
                // Debug.WriteLine($"{materialName}({drawCount}): {materialComment}");
                materials[i] = new Material
                {
                    Name = materialName,
                    ColorRGBA = diffuseRGBA,
                    ColorTexture = colorTexture,
                    DrawCount = drawCount,
                };
            }

            int boneCount = r.Get<int>();
            var bones = new Bone[boneCount];
            for (int i = 0; i < boneCount; ++i)
            {
                var boneName = r.PmxText(header.TextEncoding);
                var boneNameEnglish = r.PmxText(header.TextEncoding);
                var position = r.Get<Vector3>();
                var parent = r.PmxIndex(header.BoneIndexSize);
                var layer = r.Get<int>();
                var boneFlags = (BoneFlags)r.Get<ushort>();
                if (boneFlags.HasFlag(BoneFlags.HasTail))
                {
                    var tail = r.PmxIndex(header.BoneIndexSize);
                }
                else
                {
                    var tailPosition = r.Get<Vector3>();
                }
                if (boneFlags.HasFlag(BoneFlags.RotationConstraint) || boneFlags.HasFlag(BoneFlags.TranslationConstraint))
                {
                    var source = r.PmxIndex(header.BoneIndexSize);
                    var weight = r.Get<float>();
                }
                if (boneFlags.HasFlag(BoneFlags.FixedAxis))
                {
                    var axis = r.Get<Vector3>();
                }
                if (boneFlags.HasFlag(BoneFlags.LocalAxis))
                {
                    var xAxis = r.Get<Vector3>();
                    var zAxis = r.Get<Vector3>();
                }
                if (boneFlags.HasFlag(BoneFlags.ExternalParent))
                {
                    r.Get<int>();
                }
                if (boneFlags.HasFlag(BoneFlags.HasIk))
                {
                    var target = r.PmxIndex(header.BoneIndexSize);
                    var iteration = r.Get<int>();
                    var limitRadians = r.Get<float>();
                    var ikChain = r.Get<int>();
                    for (int j = 0; j < ikChain; ++j)
                    {
                        var chain = r.PmxIndex(header.BoneIndexSize);
                        var hasAngleLimit = r.Get<byte>();
                        if (hasAngleLimit != 0)
                        {
                            var lower = r.Get<Vector3>();
                            var upper = r.Get<Vector3>();
                        }
                    }
                }
                bones[i] = new Bone
                {
                    Name = boneName,
                    Position = position.TurnY180(),
                    Parent = parent,
                };
                // Debug.WriteLine($"[{i}]{boneName}: {boneFlags}: parent=>{parent}");
            }

            return new Model
            {
                Name = name,
                NameEnglish = nameEnglish,
                Comment = comment,
                CommentEnglish = commentEnglish,
                VertexGeometries = vertexGeometries,
                VertexTextures = vertexTextures,
                VertexSkins = vertexSkins,
                IndexStride = (int)header.VertexIndexSize,
                Indices = indices,
                Textures = textures,
                Materials = materials,
                Bones = bones,
            };
        }
    } // class
} // namespace