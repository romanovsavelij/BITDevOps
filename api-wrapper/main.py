from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/pokemon')
def get_pokemon():
    response = requests.get(f'https://pokeapi.co/api/v2/pokemon/ditto')
    return jsonify(response.json())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
