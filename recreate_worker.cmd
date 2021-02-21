
SET NUM_WORKER=%1
SET VM_NAME=lab-worker-%NUM_WORKER%


VBoxManage controlvm %VM_NAME% poweroff
VBoxManage unregistervm %VM_NAME% --delete
VBoxManage clonevm centostemplate --basefolder c:\desarrollo\vbox --mode=all --name=%VM_NAME% --register
VBoxManage startvm %VM_NAME%  --type headless

@echo ansible-playbook -i hosts -l lab-new-host.local --extra-vars="target_hostname=%VM_NAME%.local" onebyone-base-config.yaml
