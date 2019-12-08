#!/bin/bash 

set -eu

source ./setenv.sh


$TUTORIAL_HOME/scripts/clean.sh tutorial

kubectl create -f $TUTORIAL_HOME/istiofiles/destination-rule-recommendation-v1-v2.yml -n tutorial
kubectl create -f $TUTORIAL_HOME/istiofiles/virtual-service-recommendation-v1_and_v2_75_25.yml -n tutorial