#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset
set -o xtrace
# set -eox pipefail #safety for script

echo "========================================================================================="
vagrant plugin install vagrant-libvirt #The vagrant-libvirt plugin is required when using KVM on Linux
vagrant plugin install vagrant-mutate #Convert vagrant boxes to work with different providers


# TESTED OK
# https://github.com/chef/bento/tree/master/packer_templates/centos
vagrant box add "bento/centos-8.2" --provider=virtualbox
vagrant mutate "bento/centos-8.2" libvirt
vagrant init --template Vagrantfile.template.erb 
# must be created in project root directory with Vagrantfile template file
vagrant up --provider=libvirt "vg-compute-10" 


vagrant init --template Vagrantfile.erb 
vagrant up --provider=libvirt "vg-compute-10"


vagrant box list #veridy installed boxes
vagrant status #Check the status of the VMs to see that none of them have been created yet
vagrant status
virsh list --all #show all running KVM/libvirt VMs


echo "========================================================================================="
