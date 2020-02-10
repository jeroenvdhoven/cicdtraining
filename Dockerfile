FROM python:3.7-slim-buster

COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_APP=server.py host=0.0.0.0
EXPOSE 5000

COPY server server

CMD ["./run.sh"]