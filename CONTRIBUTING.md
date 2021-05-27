Azure CLI project:
Script for creating virtual machines for the k8s cluster in the configuration:

  1. Hardware requirements:
  
    - k8s cluster:  
      - 2x CPU;
      - 2GB RAM;
    - admin-server:
      - 1x CPU;
      - 2GB RAM;
  2. OS requirements:
  
     - UbuntuLTS 18.04 or higher
  3. Architecture:
  
     - k8s cluster:
       - master server #1: vm-k8s-master-01 [10.0.1.10];
       - worker server #1: vm-k8s-worker-01 [10.0.1.11];
       - worker server #2: vm-k8s-worker-02 [10.0.1.12];
     - admin server: vm-k8s-admin-server [10.0.1.100];

4. Logs (ansible):
   - vm-k8s-admin-server;
   - /home/init-cluster/admin-scripts/*.log;
5. After installing k8s, remove vm-k8s-admin-server;   
