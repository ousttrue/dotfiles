using System.Reflection.Metadata.Ecma335;
using System.Runtime.InteropServices;

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
}