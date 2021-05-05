#!/bin/bash
kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address=10.0.1.10
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"