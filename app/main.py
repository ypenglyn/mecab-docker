from flask import Flask
from flask import request
from flask import jsonify
import MeCab
import json


app = Flask(__name__)

@app.route("/mecab/v1", methods=["GET"])
def hello():
    keyword = request.args.get('word') 
    mecab = MeCab.Tagger('-d /usr/lib/mecab/dic/mecab-ipadic-neologd/')
    mecab.parse('')
    node = mecab.parseToNode(keyword)
    tokens = []
    while node:
        token = {}
        token['surface'] = node.surface
        token['feature'] = node.feature 
        tokens.append(token)
        node = node.next
    #return json.dumps(tokens, indent=4, sort_keys=True,  ensure_ascii=False).encode('utf8')
    return jsonify(tokens)

if __name__ == "__main__":
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=True, port=80)
