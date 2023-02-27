import json

from flask_cors import CORS
from rebel import textToTriplet, extract_triplets
from flask import Flask, request
import traceback

app = Flask(__name__)
CORS(app)


@app.route('/')
def information_extraction_with_rebel():
    try:
        print("Server running")
        text = request.args.get('text', None)
        print("text = ", text)


        if not text:
            return 'Missing text parameter'

        # text to triplets
        decoded_preds = textToTriplet(text=text, num_return_sequence=10, num_beams=10)

        extracted_triplets = list()
        for idx, sentence in enumerate(decoded_preds):
            print(f'Prediction triplets sentence {idx}')
            extracted_triplets.extend(extract_triplets(sentence))
            print(extract_triplets(sentence))

        # save triplet to file
        with open("data.json", "w") as f:
            json.dump(extracted_triplets, f)

        return json.dumps(extracted_triplets)
    except Exception as e:
        return 'An error has occured:' + str(e) + " " + traceback.format_exc()


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
