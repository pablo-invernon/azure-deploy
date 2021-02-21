
SET VM_NAME=lab-nfs
SET VM_DISK=nfs
SET VM_DISK_PATH=c:\desarrollo\vbox\%VM_NAME%\%VM_DISK%.vdi

VBoxManage controlvm %VM_NAME% poweroff
VBoxManage storageattach %VM_NAME% --storagectl SATA --medium emptydrive --port 1 --device 0 --type hdd
VBoxManage closemedium disk %VM_DISK_PATH% --delete
VBoxManage unregistervm %VM_NAME% --delete
VBoxManage clonevm centostemplate --basefolder c:\desarrollo\vbox --mode=all --name=%VM_NAME% --register
VBoxManage createmedium disk --filename %VM_DISK_PATH% --size 20480 --format VDI
VBoxManage storagectl %VM_NAME% --name SATA --portcount 2
VBoxManage storageattach %VM_NAME% --storagectl SATA --medium %VM_DISK_PATH% --port 1 --device 0 --type hdd
VBoxManage startvm %VM_NAME%  --type headless


@echo ""
@echo ""
@echo Run:
@echo ansible-playbook -i hosts -l lab-new-host.local --extra-vars="target_hostname=%VM_NAME%.local" onebyone-base-config.yaml
