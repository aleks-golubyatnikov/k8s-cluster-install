#!/bin/bash

chmod 0755 -R ./  

./servers/1-create-admin-server.sh
./servers/2-create-servers-for-k8s.sh