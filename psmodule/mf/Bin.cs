using System.Runtime.InteropServices;

namespace mf
{
    class Bin
    {
        List<byte> _bytes = new List<byte>();
        public List<byte> Bytes => _bytes;

        List<Lbsm.LbsmBufferView> _views = new List<Lbsm.LbsmBufferView>();
        public IReadOnlyCollection<Lbsm.LbsmBufferView> BufferViews => _views;

        public int Push<T>(string name, ReadOnlySpan<T> span) where T : struct
        {
            var index = _views.Count;
            var bytes = MemoryMarshal.Cast<T, byte>(span);
            _views.Add(new Lbsm.LbsmBufferView
            {
                name = name,
                byteOffset = _bytes.Count,
                byteLength = bytes.Length,
            });
            _bytes.AddRange(bytes);
            return index;
        }
    }
}
