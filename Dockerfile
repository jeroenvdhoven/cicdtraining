FROM python:3.7-slim-buster
WORKDIR server

COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_APP=app.py host=0.0.0.0
EXPOSE 5000

COPY ./server ./server
COPY ./training ./training
COPY ./run.sh ./run.sh

CMD ["./run.sh"]