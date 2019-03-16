#!/bin/bash 

set -eu

source ./setenv.sh

! istioctl delete -f  $TUTORIAL_HOME/istiofiles/virtual-service-recommendation-v1.yml -n tutorial