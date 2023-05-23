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