#!/bin/bash


# metallb
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl delete -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml
kubectl delete -f metallb_test.yaml


# ingress
kubectl delete namespace ingress-nginx
kubectl delete clusterrole ingress-nginx
kubectl delete clusterrole nginx-ingress-clusterrole
kubectl delete clusterrole ingress-nginx-admission
kubectl delete clusterrolebinding ingress-nginx
kubectl delete clusterrolebinding ingress-nginx-admission
kubectl delete validatingwebhookconfiguration ingress-nginx-admission
