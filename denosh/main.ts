const encoder = new TextEncoder();

class Readline {
  buffer;
  ait;

  constructor() {
    Deno.stdin.setRaw(true);
    this.ait = Deno.stdin.readable.getReader();
    this.buffer = new Uint8Array();
  }

  dispose() {
    Deno.stdin.setRaw(false);
  }

  async getLine() {
    while (true) {
      const { value } = await this.ait.read();
      if (!value) {
        break;
      }
      // console.log(value);
      const buf = new Uint8Array(value.length + 2);
      for (let i = 0; i < value.length; ++i) {
        const l = value[i];
        buf[i] = l;
        switch (l) {
          case 3:
            // CTRL-C
            return null;

          case 4:
            // CTRL-D
            return null;

          case 13: {
            // enter
            buf[i + 1] = 10;
            buf[i + 2] = 0;
            Deno.stdout.write(buf);
            // commit
            const line = Uint8Array.from([...this.buffer, ...buf]);
            this.buffer = value.subarray(i + 1);
            return line;
          }

          default:
            // echo back
            buf[i + 1] = 0;
            Deno.stdout.write(buf);
            break;
        }
      }
      this.buffer = Uint8Array.from([...this.buffer, ...buf]);
    }
  }
}

const rl = new Readline();
while (true) {
  // prompt
  Deno.stdout.write(encoder.encode("> \n"));

  // readline
  const value = await rl.getLine();
  if (value) {
    Deno.stdout.write(value);
  } else {
    break;
  }
}
