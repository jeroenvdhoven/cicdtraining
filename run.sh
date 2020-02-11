#!/bin/bash

default_host="127.0.0.1"
host=${host:-$default_host}

default_mode="prod"
deploy_mode=${deploy_mode:-$default_mode}

ls -la

if [ "$deploy_mode" == "dev" ]
then
  if [ -d "code_volume" ]
  then
    echo "Running of code volume"
    FLASK_APP=code_volume.server.app flask run -h $host --reload
  else
    echo "Running of normal folder"
    FLASK_APP=server.app flask run -h $host --reload
  fi
else
  gunicorn server.app:app -b $host:5000
fi