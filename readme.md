### Cyberteam local lando setup script

This will pull in the [lando-local-cloud](https://github.com/protitude/lando-local-cloud) ansible playbook and run some extra commands to setup the [cyberteam_drupal](https://github.com/necyberteam/cyberteam_drupal) site.

To get started, type ```./cyberteam-setup.sh```. This will kick off the script and you will be asked the ip of your server and the username you want to create. This ansible playbook was built using linode which initially only creates a root user account, therefore this entire playbook is ran as root.

## Secrets
The above script will walk you through setting up your secrets file, but if you'd like to create a file with your password in it to make it so you don't have to type it out, then you can run the following commands:

```
openssl rand -base64 512 |xargs > vaultkeyfile
cd lando-local-cloud
cat example-secrets.yml|pbcopy #MacOS only — this will copy to your clipboard
ansible-vault create secrets.yml --vault-password-file=vaultkeyfile
```

See the ```example-secrets.yml``` file to get an example of all of the variables you should place in this file.
