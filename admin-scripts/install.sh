#!/bin/bash

apt-get -y install sshpass >> install.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/initial.yml >> install.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/iptables.yml >> install.log