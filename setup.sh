#!/bin/bash

chmod 0755 -R ./  

./servers/1-create-admin-server.sh >> installation-admin-server.log
./servers/2-create-servers-for-k8s.sh >> installation-k8s-servers.log
./install-cluster.sh >> installation-k8s-cluster.log