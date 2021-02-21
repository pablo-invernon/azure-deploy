# Despliegue de infraestructura 

## Local

Hosts:

192.168.56.102 lab-ansible.local
192.168.56.104 lab-kube-master.local
192.168.56.105 lab-kube-worker.local
192.168.56.106 lab-docker.local
192.168.56.107 lab-podman.local
192.168.56.109 lab-nfs.local
192.168.56.103 lab-kvm.local

Los despliegues se han realizado utilizando máqinas virtualizadas con VirtualBox de Oracle versión 6.1.x. A continuación se presentan varios comandos relevantes en la gestión de máquinas virtuales:

 - VBoxManage list vms
 - VBoxManage startvm  
 - VBoxManage controlvm nombre_manquina acpipowerbutton
 - VBoxManage unregistervm  --delete
 - VBoxManage registervm
 - VBoxManage showvminfo nombre_maquina | grep -i mac
 - VBoxManage dhcpserver findlease --interface 'VirtualBox Host-Only Ethernet Adapter' --mac-address=080027133c5c
 
 - VBoxManage clonevm centostemplate --basefolder c:\desarrollo\vbox --mode=all --name=lab-docker --register

 Creada template con:

 - IP: 111
 - Usuarios: root / user / ansible
 - Password: centostemplate
 - Clave RSA : ~/.ssh/id_rsa


recreate_nfs.cmd
ansible-playbook -i hosts -l lab-new-host.local --extra-vars="target_hostname=lab-nfs.local" base-config.yaml
recreate_master.cmd
ansible-playbook -i hosts -l lab-new-host.local --extra-vars="target_hostname=lab-master.local" onebyone-base-config.yaml
recreate_workder.cmd 1
ansible-playbook -i hosts -l lab-new-host.local --extra-vars="target_hostname=lab-worker-1.local" onebyone-base-config.yaml
recreate_worker.cmd 2
ansible-playbook -i hosts -l lab-new-host.local --extra-vars="target_hostname=lab-worker-2.local" onebyone-base-config.yaml