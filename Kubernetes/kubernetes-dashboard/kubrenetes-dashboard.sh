#!/bin/bash

# metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
# Troubleshooting:
## Error from server (ServiceUnavailable): the server is currently unable to handle the request (get nodes.metrics.k8s.io)
## https://freedeveloper.tistory.com/412
## https://github.com/kubernetes-sigs/metrics-server/issues/300#issuecomment-525336815
## deployments를 수정 --kubelet-insecure-tls 옵션 추가
# kubectl edit deployments.app -n kube-system metrics-server

# kubernetes dashboard v2.4.0
kubectl apply -f kubernetes-dashboard-not-fully-secure.yaml

# 모든 권한 접근 설정
# https://github.com/kubernetes/dashboard/issues/4179#issuecomment-762225102
kubectl apply -f kubernetes-dashboard-role.yaml

# Ingress 추가
kubectl apply -f kubernetes-dashboard-ingress.yaml

# 접속 token 획득방법:
# 1. serviceaccount의 token 이름 획득
# kubectl describe serviceaccounts -n kubernetes-dashboard kubernetes-dashboard
# 2. token의 secret 조회 (예시: kubernetes-dashboard-token-xq564 이름의 token명일 경우)
# kubectl describe secret kubernetes-dashboard-token-xq564 -n kubernetes-dashboard