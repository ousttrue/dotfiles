[[python]] の html template

- [Jinja2の使い方がわかるとFlaskを用いた開発がよりスマートになる - Qiita](https://qiita.com/oliva/items/7ae5de21307d101b4759)

# vscode
- [Flask　コーディングメモ - Qiita](https://qiita.com/sskyh/items/52b965b378cc916be3ab)
- [【Visual Studio Code】入れておきたい拡張機能と設定 -jinja2篇- - techblogchanはかく語りき](https://www.techblogchan.com/entry/2021/03/29/080000)

## better jinja
```json:settings.json
{
	"files.associations": { "*.html": "jinja-html" },
	"[jinja-html]": { "editor.formatOnSave": false }
}
```

# flask
[[flask]]
- [【随時更新】Flaskのjinja2テンプレートエンジンのチートシート | たぬハック](https://tanuhack.com/jinja2-cheetsheet/)

* main.py
	* templates/index.html
	- static/index.css `<link rel="stylesheet" href="/static/style.css">`

```python:main.py
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def index():
  return render_template('index.html')

if __name__ == '__main__':
  app.run(debug=True)
```
