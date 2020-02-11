FROM python:3.7-slim-buster
WORKDIR modelserver

COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

ENV host=0.0.0.0
EXPOSE 5000

COPY ./server ./server
COPY shell_scripts/run.sh ./shell_scripts/run.sh

CMD ["./shell_scripts/run.sh"]