#!/bin/bash


# https://artifacthub.io/packages/helm/helm-openldap/openldap-stack-ha

helm install openldap helm-openldap/openldap-stack-ha --version 2.1.6 \
  --namespace openldap \
  --create-namespace \
  --values values.yaml
