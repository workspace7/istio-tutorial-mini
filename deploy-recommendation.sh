#!/bin/bash 
# TODO revisit

set -eu

TUTORIAL_HOME='/Users/kameshs/git/redhat-developer-demos/istio-tutorial'

_clean="no"

while getopts ":c:v:" opt; do
  case $opt in
    c) _clean="$OPTARG"
    ;;
    v) _version="$OPTARG"
    ;;
   \?) echo "Invalid option -$OPTARG" >&2
   ;;
  esac
done

printf "Clean Deploy %s \n" "$_clean"
printf "Version of deploy is %s\n" "$_version"

if [ "$_clean" = "yes" ];
then 
 ! kubectl delete  -n tutorial -f  "recommendation-build.yaml"
 ! kubectl delete  -n tutorial -f "$TUTORIAL_HOME/recommendation/kubernetes/Service.yml"
 kubectl create -n tutorial  -f "$TUTORIAL_HOME/recommendation/kubernetes/Service.yml"
 # Set service to be node port
 kubectl -n tutorial get svc recommendation -o yaml | yq w - spec.type NodePort | kubectl apply -f -
fi

if [ "$_version" = 'v1' ]; 
then 
 ! kubectl delete  -n tutorial -f  "recommendation-build.yaml"
 [ "$_clean" = "yes" ] && ! kubectl delete -f "$TUTORIAL_HOME/recommendation/kubernetes/Deployment.yml" -n tutorial
 sed 's|--imgTag--|v1|; s|--gitRev--|master|' recommendation-build.yaml |  kubectl apply -n tutorial -f - 
 kubectl apply -f "$TUTORIAL_HOME/recommendation/kubernetes/Deployment.yml" -n tutorial
fi

if [ "$_version" = 'v2' ]; 
then 
 ! kubectl delete  -n tutorial -f  "recommendation-build.yaml"
 sed 's|--imgTag--|v2|; s|--gitRev--|recommendation-v2|' recommendation-build.yaml |  kubectl apply  -n tutorial -f -
 [ "$_clean" = "yes" ] && ! kubectl delete -f "$TUTORIAL_HOME/recommendation/kubernetes/Deployment-v2.yml" -n tutorial
 kubectl apply -f "$TUTORIAL_HOME/recommendation/kubernetes/Deployment-v2.yml" -n tutorial
fi

