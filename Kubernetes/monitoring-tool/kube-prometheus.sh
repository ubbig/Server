#!/bin/bash


git clone git@github.com:prometheus-operator/kube-prometheus.git
cd kube-prometheus

# Create the namespace and CRDs, and then wait for them to be available before creating the remaining resources
kubectl apply --server-side -f manifests/setup
until kubectl get servicemonitors --all-namespaces ; do date; sleep 1; echo ""; done
kubectl apply -f manifests/



# teardown the stack
# kubectl delete --ignore-not-found=true -f manifests/ -f manifests/setup
