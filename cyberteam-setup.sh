#!/bin/bash

if [ $# -eq 0 ]
  then
    echo Input linode ip
    read linode_ip
    echo Input username
    read linode_username
    echo "Use (1) '--vault-password-file=../vaultkeyfile' OR (2) '--ask-vault-pass' for secrets file"
    read vault_selection
    if [ $vault_selection == 1 ]; then
      vault="--vault-password-file=../vaultkeyfile"
    else
      vault="--ask-vault-pass"
    fi
  else
    linode_username=$1
    linode_ip=$2
    vault="--vault-password-file=../vaultkeyfile"
fi

if [ ! -d "lando-local-cloud" ]; then
  git clone git@github.com:protitude/lando-local-cloud.git
fi

cd lando-local-cloud

sed -i '' -e '$ d' inventory/hosts.ini
echo $linode_ip >> inventory/hosts.ini

if [ ! -f "secrets.yml" ]; then
  echo "You will be asked to type a password for your secrets file, use the below example to create your secrets file. This will automatically be copied to your clipboard on MacOS: "
  sed "s/username/$linode_username/g" example-secrets.yml
  sed "s/username/$linode_username/g" example-secrets.yml|pbcopy
  read -p "Press enter to continue"
  ansible-vault create secrets.yml
fi

if [ ! -d "roles/cyberteam" ]; then
  echo "    - cyberteam" >> playbook.yml
  cp -R ../cyberteam roles
fi

ansible-galaxy install -r requirements.yml
# If root user, run the below command
ansible-playbook $vault -i inventory/hosts.ini --skip-tags "user_update" playbook.yml
# If not root user, run the below command
#ansible-playbook $vault --ask-become-pass -i inventory/hosts.ini --skip-tags "user_create" playbook.yml

