#!/bin/bash 

set -e

TUTORIAL_HOME=${TUTORIAL_HOME:-'/Users/kameshs/git/redhat-developer-demos/istio-tutorial'}

# cd $TUTORIAL_HOME/preference/java/springboot
# mvn clean package 

# docker build -t example/preference:v1 .

if [ "$1" = "clean" ];
then 
 # ! kubectl delete  -n tutorial -f  "preference-build.yaml"
 kubectl delete  -n tutorial  -f  "$TUTORIAL_HOME/preference/kubernetes/Deployment.yml"
 kubectl delete  -n tutorial -f "$TUTORIAL_HOME/preference/kubernetes/Service.yml"
 exit 0
fi

# kubectl create -n tutorial -f  "preference-build.yaml"
kubectl create -n tutorial  -f  "$TUTORIAL_HOME/preference/kubernetes/Deployment.yml"
kubectl create -n tutorial  -f "$TUTORIAL_HOME/preference/kubernetes/Service.yml"
 # Set service to be node port
# kubectl -n tutorial get svc preference -o yaml | yq w - spec.type NodePort | kubectl apply -f -
