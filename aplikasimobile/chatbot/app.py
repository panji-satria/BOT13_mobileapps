from flask import Flask, request, jsonify
from spellchecker import SpellChecker
import logging
from flask_cors import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

spell = SpellChecker()

# Configuration for logging to include timestamp and log file
logging.basicConfig(level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s', filename='app.log')

def get_bot_response(user_message):
    corrected_message = ' '.join(spell.correction(word) for word in user_message.split())

    if 'apa kabar' in corrected_message.lower():
        return 'Bot: Saya baik, terima kasih!'
    elif 'siapa namamu' in corrected_message.lower():
        return 'Bot: Saya adalah BotCerdas 3000.'
    elif 'bagaimana cuaca' in corrected_message.lower():
        return 'Bot: Maaf, saya tidak bisa memberikan informasi cuaca saat ini.'
    else:
        return 'Bot: Maaf, saya tidak mengerti pertanyaan Anda.'

@app.route('/models', methods=['POST'])
def send_message():
    try:
        data = request.get_json()
        user_message = data.get('message', '')  # Use get to avoid KeyError

        # Log the received message from the Flutter application
        logging.debug('Received message: %s', user_message)

        bot_response = get_bot_response(user_message)

        response = {
            'text': bot_response
        }

        # Log the response sent back to the Flutter application
        logging.debug('Sending response: %s', response)

        return jsonify(response), 200
    except Exception as e:
        # Log the error that occurred
        logging.error('Exception while processing message: %s', e)
        return jsonify({'error': 'Internal Server Error'}), 500

if __name__ == '__main__':
    app.run(port=5000, debug=True)
