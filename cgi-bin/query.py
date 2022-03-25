#!/usr/bin/env python
import os
import io
URL = 'https://www.google.com/search?btnG=Google'


def local_cgi(query):
    sio = io.StringIO()
    sio.write('Content-type: text/plain\r\n')
    sio.write(f'W3m-control: BACK\r\n')
    sio.write(f'W3m-control: TAB_GOTO {URL}&q={query}\r\n')
    # sio.write('W3m-control: DELETE_PREVBUF\r\n')
    sio.write('\r\n')
    sio.write('hello\r\n')
    return sio.getvalue()


if __name__ == '__main__':
    print(local_cgi(os.environ['QUERY_STRING']))
