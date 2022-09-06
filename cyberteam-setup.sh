#!/bin/bash
echo Input linode ip
read linode_ip
echo Input username
read linode_username

git clone git@github.com:protitude/lando-local-cloud.git
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

if [ -d "roles/cyberteam" ]
then
  echo "    - cyberteam" >> playbook.yml
  cp -R ../cyberteam roles/
fi

ansible-galaxy install -r requirements.yml

ansible-playbook --ask-vault-pass -i inventory/hosts.ini playbook.yml

if [ ! -f "extra-commands.sh" ]; then
  ./extra-commands.sh
fi

