#!/bin/bash

docker-compose up -d mysql
echo Waiting 30 seconds for mysql to bootstrap and initialize
sleep 30
./scripts/create_db.sh
docker-compose up -d
