#!/bin/bash

apt-get -y install sshpass >> install.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/initial.yaml >> install-initial.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/iptables.yaml >> install-iptables.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/docker.yaml >> install-docker.log