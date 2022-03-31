python windows
#python

>>> import site
>>> site.getusersitepackages()

`%USERPROFILE%\\AppData\\Roaming\\Python\\Python36\\site-packages`

`usercustomize.py`

code:usercustomize.py
 この方法はもうだめ

[* locale.getpreferredencoding()]
https://qiita.com/methane/items/6e294ef5a1fad4afa843

code:bat
 C:\Users\ousttrue>python
 Python 3.6.8 (tags/v3.6.8:3c6b436a57, Dec 23 2018, 23:31:17) [MSC v.1916 32 bit (Intel)] on win32
 Type "help", "copyright", "credits" or "license" for more information.
 >>> import locale
 >>> locale.getdefaultlocale()
 ('ja_JP', 'cp932')
 >>> quit()

code:bat
 C:\Users\ousttrue>set LANG=ja_JP.UTF-8
 C:\Users\ousttrue>python
 Python 3.6.8 (tags/v3.6.8:3c6b436a57, Dec 23 2018, 23:31:17) [MSC v.1916 32 bit (Intel)] on win32
 Type "help", "copyright", "credits" or "license" for more information.
 >>> locale.getdefaultlocale()
 Traceback (most recent call last):
   File "<stdin>", line 1, in <module>
 NameError: name 'locale' is not defined
 >>> quit()

code:python
 >>> locale.setlocale(locale.LC_ALL, 'ja_JP.UTF-8')
 'ja_JP.UTF-8'
 >>> locale.getlocale()
 ('ja_JP', 'UTF-8')

code:python
 >>> import os
 >>> os.environ['LANG']
 'ja_JP.UTF-8'
 >>> import locale
 >>> locale.getdefaultlocale()
 ('ja_JP', 'cp932')


