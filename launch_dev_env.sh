#!/bin/bash

docker-compose run -e deploy_mode=dev -p 5000:5000 webserver
