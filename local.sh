#!/bin/bash

# source .env
source .auth

if [[ -z $id_rsa ]]; then
  echo "Error id_rsa is empty. Please add a .auth file.";
  exit 1;
fi

if [[ -z $id_rsa_pub ]]; then
  echo "Error id_rsa_pub is empty. Please add a .auth file.";
  exit 1;
fi

mkdir -p ${HOME}/.ssh
echo "${id_rsa_pub}" | base64 -d > ${HOME}/.ssh/id_rsa.pub
echo "${id_rsa}" | base64 -d > ${HOME}/.ssh/id_rsa

chmod 600 ${HOME}/.ssh/*
cp hosts /etc/ansible/

ansible --version
chmod 755 .

out_put=$(ansible nodes -m ping -u pi)

# if echo "$out_put" | grep -q '"unreachable": true'; then
#     echo "Some hosts are unreachable."
# else
#     ansible-playbook ansible/turing.yml --diff
# fi

ansible-playbook ansible/turing.yml --limit rk1 --diff
