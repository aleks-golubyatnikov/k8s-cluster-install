#!/bin/bash

chmod 0755 -R ./  

./servers/1-create-admin-server.sh >> installation-admin.log
./servers/2-create-servers-for-k8s.sh >> installation-k8s.log
./install-cluster.sh