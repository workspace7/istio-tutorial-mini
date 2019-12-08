#!/bin/bash

set -eu

_CURR_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

PROFILE_NAME=${PROFILE_NAME:-istio-tutorial}
ISTIO_VERSION=${ISTIO_VERSION:-1.0.5}

KNATIVE_BUILD_VERSION=${KNATIVE_BUILD_VERSION:-v0.4.0}

minikube profile ${PROFILE_NAME}

minikube -p ${PROFILE_NAME} delete

minikube start -p ${PROFILE_NAME} \
  --memory=8192 \
  --cpus=4 \
  --vm-driver=hyperkit\
  --kubernetes-version=v1.12.0 \
  --network-plugin=cni \
  --enable-default-cni \
  --container-runtime=cri-o \
  --bootstrapper=kubeadm \
  --extra-config=apiserver.enable-admission-plugins="LimitRanger,NamespaceExists,NamespaceLifecycle,ResourceQuota,ServiceAccount,DefaultStorageClass,MutatingAdmissionWebhook"

kubectl create ns tutorial

kubectl label namespaces tutorial istio-injection=enabled

kubens tutorial 

function timeout() {
  SECONDS=0; TIMEOUT=$1; shift
  while eval $*; do
    sleep 5
    [[ $SECONDS -gt $TIMEOUT ]] && echo "ERROR: Timed out" && exit -1
  done
}

function wait_for_all_pods {
  timeout 300 "kubectl get pods -n $1 2>&1 | grep -v -E '(Running|Completed|STATUS)'"
}

# sed -i "s|ansible_host:.*|ansible_host: $(minikube ip)|" inventory/host_vars/minikube
# sed -i "s|ansible_ssh_private_key_file:.*|ansible_ssh_private_key_file: ~/.minukube/machines/$PROFILE_NAME/id_rsa|" inventory/host_vars/minikube

# Setup build 
kubectl apply --filename https://github.com/knative/build/releases/download/${KNATIVE_BUILD_VERSION}/build.yaml
# TODO just to make sure all missing ones are upated - just to avoid  errors/warnings
kubectl apply --filename https://github.com/knative/build/releases/download/${KNATIVE_BUILD_VERSION}/build.yaml

wait_for_all_pods knative-build 

if [ ! -d "istio-${ISITO_VERSION}" ]; 
then 
  curl -L "https://github.com/istio/istio/releases/download/${ISTIO_VERSION}/istio-${ISTIO_VERSION}-osx.tar.gz" | tar xz
fi 

# Setup istio 
kubectl apply -f "./istio-${ISTIO_VERSION}/install/kubernetes/helm/istio/templates/crds.yaml"
kubectl apply -f "./istio-${ISTIO_VERSION}/install/kubernetes/istio-demo.yaml"

kubectl apply -f ./k8s -n tutorial

wait_for_all_pods istio-system 
