#!/bin/bash
addrepos() {
    sudo add-apt-repository ppa:saltstack/salt  
    sudo apt-get update  
}

saltminion() {
    sudo apt-get install salt-minion
    read -p "Ready to update the salt-minion file [Y/n]:" choice
    if [ $choice != "n" ] ; then
      sudo nano /etc/salt/minion  
      read -p "Ready to update the salt-minion id [Y/n]:" choice2
      if [ $choice2 != "n" ] ; then
        sudo nano /etc/salt/minion  
      fi
      read -p "Ready to restart server [Y/n]:" choice2
      if [ $choice2 != "n" ] ; then
        sudo service salt-minion restart
      fi
    fi
}

saltmaster() {
    sudo apt-get install salt-master
    read -p "Ready to update the salt-master file [Y/n]:" choice
    if [ $choice != "n" ] ; then
      sudo nano /etc/salt/master  
      read -p "Ready to restart server [Y/n]:" choice2
      if [ $choice2 != "n" ] ; then
        sudo service salt-master restart
      fi
    fi
}

read -p "Configuring this as Salt-Master [Y/n]:" choice
addrepos
if [ $choice == 'n' ]; then
    saltminion
else
    saltmaster
fi


