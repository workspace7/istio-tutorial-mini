#!/bin/bash 

# url=${1:-`minikube service customer -n tutorial  --url`}
url='http://istio-ingressgateway-istio-system.apps.cluster-cgk-d8e7.cgk-d8e7.open.redhat.com/customer'
#url='http://helloworld-tutorial-0.apps.cluster-blr-1f87.blr-1f87.open.redhat.com/'

while true
do http --body $url
sleep .5
done