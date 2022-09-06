### Cyberteam local lando setup script

This will pull in the [lando-local-cloud](https://github.com/protitude/lando-local-cloud) ansible playbook and run some extra commands to setup the [cyberteam_drupal](https://github.com/necyberteam/cyberteam_drupal) site.

If you have extra commands you'd like to run at the end of the script (ie: rsync your ssh key to the server), you can create a file named ```extra-commands.sh``` that will be ran at the end. Be sure to make it executable ```chmod +x extra-commands.sh```. The username and IP will be passed to it respectively as ```$1``` and ```$2```.

To get started, type ```./cyberteam-setup.sh```. This will kick off the script and you will be asked the ip of your server and the username you want to create. This ansible playbook was built using linode which initially only creates a root user account, therefore this entire playbook is ran as root.
