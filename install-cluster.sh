#!/bin/bash

az vm extension set \
  --publisher Microsoft.Azure.Extensions \
  --version 2.0 \
  --name CustomScript \
  --vm-name vm-k8s-admin-server \
  --resource-group RG-k8s-cluster \
  --settings '{"commandToExecute":"cd /home/init-cluster/admin-scripts && bash ./install.sh"}'
