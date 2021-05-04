#!/bin/bash

apt-get -y install sshpass >> install.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/initial.yaml >> install.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/iptables.yaml >> install.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/docker.yaml >> install.log