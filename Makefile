IMAGE := alpine/fio
APP:="scripts/usernetes-containerd.sh"

deploy-boxes:
	bash scripts/deploy-boxes.sh

deploy-libvirt:
	bash scripts/deploy-libvirt.sh

deploy-vagrant:
	bash scripts/deploy-vagrant.sh
	
.PHONY: deploy-libvirt deploy-vagrant
