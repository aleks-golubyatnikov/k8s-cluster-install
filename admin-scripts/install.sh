#!/bin/bash

apt-get -y install sshpass >> install.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/initial.yaml >> install-initial.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/iptables.yaml >> install-iptables.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/docker.yaml >> install-docker.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/kubeadm.yaml >> install-kubeadm.log

ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/init-master-node.yaml >> init-master-node.log
ansible-playbook -i ../ansible-playbook/hosts ../ansible-playbook/join-worker-node.yaml >> join-worker-node.log