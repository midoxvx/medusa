#!/bin/bash

sudoers_d=/etc/sudoers.d
key_path=${HOME}/.ssh/id_rsa.pub

# create medusa user
# make medusa sudoer
# install medusa's public key on target hosts for paswordless authentication

sudo ansible all -u root -i inventory -m user -a "user=${USER} state=present"
sudo ansible all -u root -i inventory -m shell -a "echo 'medusa  ALL=(ALL)       NOPASSWD: ALL' > ${sudoers_d}/${USER}"
sudo ansible 'all,!managed-node-3' -u root -i inventory -m authorized_key -a "user=${USER} state=present key=\"{{lookup(\'file\', \'${HOME}/.ssh/id_rsa.pub\')}}\""
