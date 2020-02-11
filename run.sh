#!/bin/bash

default_host="127.0.0.1"
host=${host:-$default_host}

default_mode="prod"
deploy_mode=${deploy_mode:-$default_mode}

if [ "$deploy_mode" == "dev" ]
then
  FLASK_APP=server.app flask run -h $host
else
  gunicorn server.app:app -b $host:5000
fi