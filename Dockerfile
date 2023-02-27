FROM python:3.9


RUN apt-get update && pip install flask && mkdir /text-to-triplet/

RUN git clone https://github.com/huggingface/neuralcoref.git && \
    cd neuralcoref && \
    pip install -r requirements.txt && \
    pip install -e . &&  \
    pip install spacy==2.3.2 &&  \
    python -m spacy download en

ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

WORKDIR /neo4j-trinity

RUN git clone https://github.com/thunlp/OpenNRE.git &&  \
    cd OpenNRE && \
    pip install -r requirements.txt && \
    pip install transformers==3.5.1 && \
    pip install numpy==1.21 && \
    pip install requests==2.25.1

COPY ./src/main.py /neo4j-trinity/OpenNRE

EXPOSE 5000

WORKDIR /neo4j-trinity/OpenNRE

CMD ["python", "main.py"]