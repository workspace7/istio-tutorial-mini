#!/bin/bash 

# url=${1:-`minikube service customer -n tutorial  --url`}
url='http://istio-ingressgateway-istio-system.apps.azr.workspace7.org/customer'
#url='http://helloworld-tutorial-0.apps.cluster-blr-1f87.blr-1f87.open.redhat.com/'

while true
do http --style='bw' --body $url
sleep .5
done