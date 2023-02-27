FROM python:3.9


RUN apt-get update

RUN git clone https://github.com/hinetabi/Knowledge-graph-using-Transformers.git && \
    cd Knowledge-graph-using-Transformers && \
    pip install -r requirements.txt && \

ENV PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

WORKDIR /Knowledge-graph-using-Transformers

CMD ["python", "main.py"]