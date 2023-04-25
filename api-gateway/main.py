from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/pokemon')
def get_pokemon():
    response = requests.get(f'http://api-wrapper.default.svc.cluster.local/pokemon')
    return jsonify(response.json())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
