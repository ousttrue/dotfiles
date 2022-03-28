from typing import Dict
import platform
import os
import subprocess

VCBARS64 = 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat'


def decode(b: bytes) -> str:
    if platform.system() == 'Windows':
        try:
            return b.decode('cp932')
        except:
            return b.decode('utf8')
    else:
        return b.decode('utf-8')


def vcvars64() -> Dict[str, str]:
    # %comspec% /k cmd
    comspec = os.environ['comspec']
    process = subprocess.Popen(
        [comspec, '/k', VCBARS64, '&', 'set', '&', 'exit'],
        stdout=subprocess.PIPE)

    stdout = process.stdout
    if not stdout:
        raise Exception()

    # old = {k: v for k, v in os.environ.items()}

    new = {}
    while True:
        rc = process.poll()
        if rc is not None:
            break
        output = stdout.readline()
        line = decode(output)

        if '=' in line:
            k, v = line.strip().split('=', 1)
            # print(k, v)
            new[k.upper()] = v

    # diff(new, old)

    if rc != 0:
        raise Exception(rc)

    return new


if platform.system() == 'Windows':
    # for luarocks detect vc
    vc_map = vcvars64()
    os.environ['VCINSTALLDIR'] = vc_map['VCINSTALLDIR']
    os.environ['PATH'] = vc_map['PATH']
    os.environ['INCLUDE'] = vc_map['INCLUDE']
    os.environ['LIB'] = vc_map['LIB']
