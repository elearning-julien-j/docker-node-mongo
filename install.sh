#!/bin/bash

sudo docker volume create mydb

sudo docker compose up -d

sudo docker compose exec db mongosh --eval "
use test;
db.count.insertOne({count: 0});
use admin;
db.auth({user: 'jean', pwd: '123456'});
use test;
db.count.insertOne({count: 0});
use admin;
db.createUser({user: 'nodeapp', pwd: '123456', roles:[{role: 'readWrite', db: 'test'}]});
"
