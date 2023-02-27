
from transformers import AutoModelForSeq2SeqLM

if __name__ == '__main__':
    model = AutoModelForSeq2SeqLM.from_pretrained("Babelscape/rebel-large")
    print(model)