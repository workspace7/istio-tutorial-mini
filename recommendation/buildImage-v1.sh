#!/bin/bash
set -e 

./mvnw clean package 

docker build --rm -t example/recommendation:v1 .