#!/bin/bash

default_host="127.0.0.1"
host=${host:-$default_host}

cd server && flask run -h $host

#docker run --name flask-server -p 5000:5000 -it cicdtraining
