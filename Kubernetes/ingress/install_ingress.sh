#!/bin/bash

# Ingress Controller 설치
## Ingress-nginx
## https://kubernetes.github.io/ingress-nginx/deploy/#quick-start
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud/deploy.yaml


# IPVS와 ARP 활성화
# https://metallb.universe.tf/installation/

# 실제 kube-proxy 적용은 아래 링크 참고하여 진행
# https://ikcoo.tistory.com/154
# # kube-proxy configMap 수정 (mode: "ipvs", strictARP: true)
# kubectl edit configmaps -n kube-system kube-proxy
# # kube-proxy 삭제 (이후 재기동 됨)
# kubectl get pod -n kube-system | grep kube-proxy | awk '{system("kubectl delete pod "$1" -n kube-system")}'
# # kube-proxy 로그 확인
# kubectl logs -n kube-system <pod name>
# # (확인필요) kube-proxy iptables mode에서 사용했던 Chain 삭제
# iptables --policy INPUT   ACCEPT
# iptables --policy OUTPUT  ACCEPT
# iptables --policy FORWARD ACCEPT
# iptables -Z # zero counters
# iptables -F # flush (delete) rules
# iptables -X # delete all extra chains
# iptables -t nat -F
# iptables -t nat -X
# iptables -t mangle -F
# iptables -t mangle -X
# iptables -t raw -F
# iptables -t raw -X


# MetalLB 설치
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml


# Configmap 배포
## 주의: addresses 범위는 사용하지 않는 ip 범위로 해야 충돌이 나지 않는다.
cat <<EOF | tee ./metallb_test.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.100.28-192.168.100.39
EOF

kubectl apply -f metallb_test.yaml


# Troubleshooting:
# metallb configmap을 수정한 후에 다시 적용하려는데, 수정사항이 반영이 안된다.
    # metallb_test.yaml / address 변경을 위해서는 기존 speaker pod를 모두 삭제하여 새 구성을 수락하도록 해야한다.
    # `kubectl delete po -n metallb-system --all`
    # https://github.com/metallb/metallb/issues/348
