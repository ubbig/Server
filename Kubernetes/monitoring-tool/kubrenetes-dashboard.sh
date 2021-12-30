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
# 1) service type을 loadbalancer로 수정
# 2) 노출 IP는 192.168.100.29  (MetalLB에서 설정한 ip 범위 내 선택)
kubectl apply -f kubernetes-dashboard.yaml


# 접속 token 획득방법:
# 1. serviceaccount의 token 이름 획득
# kubectl describe serviceaccounts -n kubernetes-dashboard kubernetes-dashboard
# 2. token의 secret 조회 (예시: kubernetes-dashboard-token-xq564 이름의 token명일 경우)
# kubectl describe secret kubernetes-dashboard-token-xq564 -n kubernetes-dashboard


# 모든 권한 접근 설정
# https://github.com/kubernetes/dashboard/issues/4179#issuecomment-762225102
cat <<EOF | tee ./kubernetes-dashboard-roles.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    k8s-app: kubernetes-dashboard
  name: kubernetes-dashboard
rules:
- apiGroups:
  - metrics.k8s.io
  resources:
  - pods
  - nodes
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - nodes
  - namespaces
  - pods
  - serviceaccounts
  - services
  - configmaps
  - endpoints
  - persistentvolumeclaims
  - replicationcontrollers
  - replicationcontrollers/scale
  - persistentvolumeclaims
  - persistentvolumes
  - bindings
  - events
  - limitranges
  - namespaces/status
  - pods/log
  - pods/status
  - replicationcontrollers/status
  - resourcequotas
  - resourcequotas/status
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - apps
  resources:
  - daemonsets
  - deployments
  - deployments/scale
  - replicasets
  - replicasets/scale
  - statefulsets
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - autoscaling
  resources:
  - horizontalpodautoscalers
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - batch
  resources:
  - cronjobs
  - jobs
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - extensions
  resources:
  - ingresses
  - daemonsets
  - deployments
  - deployments/scale
  - networkpolicies
  - replicasets
  - replicasets/scale
  - replicationcontrollers/scale
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - networking.k8s.io
  resources:
  - ingresses
  - networkpolicies
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - policy
  resources:
  - poddisruptionbudgets
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - storage.k8s.io
  resources:
  - storageclasses
  - volumeattachments
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - rbac.authorization.k8s.io
  resources:
  - clusterrolebindings
  - clusterroles
  - roles
  - rolebindings
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
  - list
  - watch
EOF
