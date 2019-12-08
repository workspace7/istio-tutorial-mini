#!/bin/bash 

set -eu

source ./setenv.sh

! kubectl replace -f $TUTORIAL_HOME/istiofiles/destination-rule-recommendation-v1-v2.yml -n tutorial
! kubectl replace -f $TUTORIAL_HOME/istiofiles/virtual-service-recommendation-v2.yml -n tutorial