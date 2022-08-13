#!/bin/bash

# Build the docker images and push to docker repo
cd `pwd`
docker build -t malleshdevops/createat-devops-task:java-spring-v1 .
docker push malleshdevops/createat-devops-task:java-spring-v1
