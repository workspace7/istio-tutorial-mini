#!/bin/bash 

set -e

TUTORIAL_HOME='/Users/kameshs/git/redhat-developer-demos/istio-tutorial'

# TODO copy the files to remote 

# cd $TUTORIAL_HOME/customer/java/springboot
# mvn clean package 

# docker build -t example/customer .

if [ "$1" = "clean" ];
then 
# ! kubectl delete  -n tutorial -f  "customer-build.yaml"
 ! kubectl delete  -n tutorial  -f  "$TUTORIAL_HOME/customer/kubernetes/Deployment.yml"
 ! kubectl delete  -n tutorial -f "$TUTORIAL_HOME/customer/kubernetes/Service.yml"
 exit 0
fi

# kubectl create   -n tutorial -f  "customer-build.yaml"
kubectl create -n tutorial  -f  "$TUTORIAL_HOME/customer/kubernetes/Deployment.yml"
kubectl create -n tutorial  -f "$TUTORIAL_HOME/customer/kubernetes/Service.yml"
# Set service to be node port
#kubectl -n tutorial get svc customer -o yaml | yq w - spec.type NodePort | kubectl apply -f -
