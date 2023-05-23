#!/bin/bash

echo "Building Docker images..."
docker build -t api-gateway -f api-gateway/Dockerfile .
docker build -t api-wrapper -f api-wrapper/Dockerfile .

echo "Applying Kubernetes manifests and Istio configurations..."
kubectl apply -f api-gateway/deployment.yaml
kubectl apply -f api-wrapper/deployment.yaml
kubectl apply -f ingress.yaml
kubectl apply -f egress.yaml
kubectl apply -f example/ingress.yaml
kubectl apply -f example/httpbin.yaml

echo "Third task addons"
kubectl create namespace mesh-external

kubectl create -n mesh-external secret tls nginx-server-certs --key my-nginx.mesh-external.svc.cluster.local.key --cert my-nginx.mesh-external.svc.cluster.local.crt
kubectl create -n mesh-external secret generic nginx-ca-certs --from-file=example.com.crt

kubectl create configmap nginx-configmap -n mesh-external --from-file=nginx.conf=./nginx.conf

kubectl apply -f example-egress/nginx.yaml

kubectl create secret -n istio-system generic client-credential --from-file=tls.key=client.example.com.key \
  --from-file=tls.crt=client.example.com.crt --from-file=ca.crt=example.com.crt

kubectl apply -f example-egress/egress.yaml
kubectl apply -n istio-system -f example-egress/origination.yaml