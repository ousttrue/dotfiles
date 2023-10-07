[[gtk]]
[[GLib]]

- [Gio – 2.0](https://docs.gtk.org/gio/)
	- [Gio – 2.0: Overview](https://docs.gtk.org/gio/overview.html)

- @2009 [GIO入門 - ふとしのブログ](https://fut-nis.hatenadiary.jp/entry/20091228/1262001333)

# GFile

# Udp
- [c - Glib/Gio Asynchronous or Threaded UDP Server - Stack Overflow](https://stackoverflow.com/questions/29012061/glib-gio-asynchronous-or-threaded-udp-server)

```python
import gi
import ctypes

gi.require_version('GLib', '2.0')
gi.require_version('Gio', '2.0')
from gi.repository import GLib, Gio

import time

buf = (ctypes.c_char * 1024)()


def io_event(channel, condition):
    status, iodata = channel.read_chars()
    print(f"IOChannel.read_chars(): {status} {iodata}")
    return True


def gio_read_socket(channel: GLib.IOChannel,
                    condition: GLib.IOCondition) -> bool:
    if (condition & GLib.IOCondition.HUP):
        # this channel is done
        return False

    data = channel.read(1024)
    print(data)
    return True


def idleCpt(user_data) -> bool:
    # print(user_data)
    time.sleep(1)
    return True


def main(port: int):
    gsockAddr = Gio.InetSocketAddress.new(
        Gio.InetAddress.new_any(Gio.SocketFamily.IPV4), port)
    assert (gsockAddr)
    print('listen', port)

    s_udp = Gio.Socket.new(Gio.SocketFamily.IPV4, Gio.SocketType.DATAGRAM,
                           Gio.SocketProtocol.UDP)
    assert (s_udp)

    if not s_udp.bind(gsockAddr, False):
        raise Exception("Erreur bind")

    fd = s_udp.get_fd()

    channel = GLib.IOChannel.win32_new_socket(fd)
    source = GLib.io_add_watch(channel, GLib.IOCondition.IN, gio_read_socket)

    loop = GLib.MainLoop.new(None, False)

    dataI = (ctypes.c_int * 1)()
    idIdle = GLib.idle_add(idleCpt, dataI)
    loop.run()


if __name__ == '__main__':
    main(1505)
```

# Tcp
- [GIO socket-server / -client example - Stack Overflow](https://stackoverflow.com/questions/9513327/gio-socket-server-client-example)

```python
import gi
import ctypes

gi.require_version("GLib", "2.0")
gi.require_version("Gio", "2.0")
from gi.repository import GLib, Gio


# this function will get called everytime a client attempts to connect
def incoming_callback(service: Gio.SocketService,
                      connection: Gio.SocketConnection, source_object,
                      user_data) -> bool:

    print("Received Connection from client!")
    istream = connection.get_input_stream()
    message = (ctypes.c_char * 1024)()
    read_size = istream.read(message, 1024, None)
    print(f"Message was: \"{message[0:read_size]}\"")
    return False


def main():
    # create the new socketservice
    service = Gio.SocketService.new()
    print(service)

    # connect to the port
    if not service.add_inet_port(1500, None):
        raise Exception()

    # don't forget to check for errors
    #   if (error != NULL)
    #   {
    #       g_error (error->message);
    #   }

    # listen to the 'incoming' signal
    service.connect("incoming", incoming_callback, None)

    # start the socket service
    service.start()

    # enter mainloop
    print("Waiting for client!")
    loop = GLib.MainLoop.new(None, False)
    loop.run()

    return 0


if __name__ == '__main__':
    main()
```
