#!/bin/bash 

source './setenv.sh'

oc login -u admin --server "$MASTER_URL"

open $MASTER_URL
