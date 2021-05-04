#!/bin/bash

# Azure CLI
# Script for creating virtual machines for the k8s cluster in the configuration:
#  --Hardware requirements:
#    - k8s cluster:  
#      - 2x CPU;
#      - 2GB RAM;
#    - admin-server:
#      - 1x CPU;
#      - 2GB RAM;
#  -- OS requirements:
#     - UbuntuLTS 18.04 or higher
#  -- Architecture:
#     - k8s cluster:
#       - master server #1: vm-k8s-master-01 [10.0.1.10];
#       - worker server #1: vm-k8s-worker-01 [10.0.1.11];
#       - worker server #2: vm-k8s-worker-02 [10.0.1.12];
#     - admin server: vm-k8s-admin-server [10.0.1.100];

az group create \
--name RG-k8s-cluster \
--location centralus

az network vnet create \
--resource-group RG-k8s-cluster \
--name AZ-k8s-vNET \
--address-prefix 10.0.0.0/16 \
--subnet-name k8s-SUBNET \
--subnet-prefix 10.0.0.0/24

az network vnet subnet create \
--address-prefixes 10.0.1.0/24 \
--name cluster-SUBNET \
--vnet-name AZ-k8s-vNET \
--resource-group RG-k8s-cluster

az network nsg create \
  --resource-group RG-k8s-cluster \
  --name NSG-ADMIN-SERVER

az network nsg rule create \
  --resource-group RG-k8s-cluster \
  --name NSG-ADMIN-SERVER-ALLOW-HTTP \
  --nsg-name NSG-ADMIN-SERVER \
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix 'VirtualNetwork' \
  --destination-port-range 80 \
  --access allow \
  --priority 200

az network nsg rule create \
  --resource-group RG-k8s-cluster \
  --name NSG-ADMIN-SERVER-ALLOW-SSH \
  --nsg-name NSG-ADMIN-SERVER \
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix 'VirtualNetwork' \
  --destination-port-range 22 \
  --access allow \
  --priority 210

az network nsg rule create \
  --resource-group RG-k8s-cluster \
  --name NSG-ADMIN-SERVER-ALLOW-TCP-6443 \
  --nsg-name NSG-ADMIN-SERVER \
  --protocol tcp \
  --direction inbound \
  --source-address-prefix '*' \
  --source-port-range '*' \
  --destination-address-prefix 'VirtualNetwork' \
  --destination-port-range 6443 \
  --access allow \
  --priority 250

az network public-ip create \
  --resource-group RG-k8s-cluster \
  --name PIP-ADMIN-SERVER \
  --sku Standard \
  --version IPv4

az network nic create \
--resource-group RG-k8s-cluster \
--name admin-server-NIC \
--subnet cluster-SUBNET \
--network-security-group NSG-ADMIN-SERVER \
--private-ip-address 10.0.1.100 \
--public-ip-address PIP-ADMIN-SERVER \
--vnet-name AZ-k8s-vNET

az vm create \
  --resource-group RG-k8s-cluster \
  --name vm-k8s-admin-server \
  --admin-username golubyatnikov \
  --admin-password Upgrade-2035UP \
  --image UbuntuLTS \
  --nics admin-server-NIC \
  --size Standard_B1ms \
   
az vm extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --vm-name vm-k8s-admin-server \
  --resource-group RG-k8s-cluster \
  --settings '{"commandToExecute":"apt-get -y update && apt-get -y install ansible && mkdir -m 0755 /home/init-cluster && git clone https://github.com/aleks-golubyatnikov/k8s-cluster-install.git /home/init-cluster && chmod 0755 -R /home/init-cluster && bash /home/init-cluster/admin-scripts/install.sh"}'
