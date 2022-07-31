#!/bin/bash

docker build -t altserver .
docker run --privileged --network host -it altserver $@