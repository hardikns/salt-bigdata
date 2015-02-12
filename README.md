WinStream BigData POC - SaltStack Scripts  
=========================================

Purpose
-------
I have written the salt scripts to automate the installation of Hadoop and allied software each server.  
These repository is to share the same. 

Assumptions
-----------
I have tested these scripts only on Ubuntu 14.04.01 server. 
 
Salt Setup
----------
  There should be on machine which should be salt master and all other machines (including this one) can be a minion (slave). 
  **Note:** This has nothing to do with Hadoop master and slave setup.  
  
### Salt Master setup:  

  1. Install Salt Master:

        sudo add-apt-repository ppa:saltstack/salt  
        sudo apt-get update  
        sudo apt-get install salt-master  

    Refer: [http://docs.saltstack.com/en/latest/topics/installation/](http://docs.saltstack.com/en/latest/topics/installation/)

  2. Update the configration file:
  
    On ubuntu the configruation file will be at location `/etc/salt/master`

    
        file_roots:  
           base:  
		     - <path of this repository>
  

    Restart the Master after this:

        sudo service salt-master restart  

### Salt Minion setup:

  **Note:**  
    If the machine running salt-master is also one of the servers to be setup with any of the hadoop components then  
    install minion on that machine also. Master and minion can run on same machine.   

  1. Install Salt Minion:

        sudo add-apt-repository ppa:saltstack/salt  
        sudo apt-get update  
        sudo apt-get install salt-minion

    Refer: [http://docs.saltstack.com/en/latest/topics/installation/](http://docs.saltstack.com/en/latest/topics/installation/)


  2. Update the configuration file:
  
    On ubuntu the configruation file will be at location `/etc/salt/minion`
  
        # Set the location of the salt master server. If the master server cannot be  
	    # resolved, then the minion will fail to start.  
	      master: <ip of your master>

    Restart the Minion after this:  

        sudo service salt-minion restart

  3. Minion Id: 
 
    Minion id is important for master to understand what changes to be deployed. Salt-Minion generally defaults the machines  
    hostname as the minion id. However this can be overridden by updating the file `/etc/salt/minion_id`. 

### Accept Minions on Salt Master

    Salt Minions will have to be accepted by Master and to this run the following command on salt master:  
  
    `sudo salt-key -L` will show you list of all minions that want to contact you. 

        Accepted Keys:
        Unaccepted Keys:
         server1
         server2
         slave1
         slave2
         reporting1
         reporting2

        Rejected Keys:

    Issue command `sudo salt-key -a <minion>` or `sudo salt-key -A`.
  

### Deploying the scripts:
  
        sudo salt '*' state.highstate 



Help on Scripts
---------------
  The scripts support roles which are setup as grains in minions. The following is a sample 
  grains file `/etc/salt/grains`

        roles:
          - mongo-config
          - mongo-shard
          - mongo-router
          - hadoop-master
          - hadoop-slave

  Based on the roles the script auto-adjusts and sets up the server. 








