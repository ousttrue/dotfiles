using System;
using System.Data;
using System.Dynamic;
using System.Runtime.InteropServices;

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

    public ReadOnlySpan<T> Get<T>()
            where T : struct
    {
      var span = GetBytes(Marshal.SizeOf<T>());
      return MemoryMarshal.Cast<byte, T>(span);
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

      var header = r.Get<Pmx.Header>()[0];
      Console.WriteLine(header);
      var a = 0;
    }
  }
}
