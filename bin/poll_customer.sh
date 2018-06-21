#!/bin/bash

# URL="customer-tutorial.$(minishift ip).nip.io"

export INGRESS_HOST='192.168.1.15'
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http")].nodePort}')
# export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

echo "Using INGRESS_HOST: $INGRESS_HOST , INGRESS_PORT: $INGRESS_PORT"

while true
do curl --resolve customer.example.org:$INGRESS_PORT:$INGRESS_HOST  -HHost:customer.example.org  http://customer.example.org:$INGRESS_PORT/
sleep .1
done

