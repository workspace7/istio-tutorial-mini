#!/bin/bash 

set -e

export ISTIO_HOME=`pwd`/istio-1.0.5
export PATH=$ISTIO_HOME/bin:$PATH

export TUTORIAL_HOME='/Users/kameshs/git/redhat-developer-demos/istio-tutorial'