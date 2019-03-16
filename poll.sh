#!/bin/bash 

url=${1:-`minikube service customer -n tutorial  --url`}

while true
do curl $url
sleep .5
done