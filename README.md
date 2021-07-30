# jenkins-elk-sandbox

~~~~
del Vagrantfile
vagrant init --template Vagrantfile.erb 


Jenkins Master Node

vagrant up  vg-compute-10
vagrant ssh vg-docker-10 (password:vagrant)

Jenkins Web Console
http://192.168.20.18:8080/

user/password: admin/admin

install default plugins

"Building on the controller node can be a security issue. You should set up distributed builds."
"Set up agent"

"Manage Jenkins-Manage Plugins-Available"
search - ansible 
Download now and install after restart
search - Configuration as Code 
Download now and install after restart
~~~~
~~~~
Jenkins Slave Node (Centos Stream 8)

vagrant up  vg-compute-11
vagrant ssh vg-docker-11 (password:vagrant)
$ whoami
vagrant
$ sudo useradd jenkins-slave1
$ sudo su - jenkins-slave1

$ ssh-keygen -t rsa -N "" -f /home/jenkins-slave1/.ssh/id_rsa
$ cat .ssh/id_rsa.pub > .ssh/authorized_keys
$ chmod 700 .ssh/authorized_keys
$ ls -lai .ssh/authorized_keys
67635957 -rwx------. 1 jenkins-slave1 jenkins-slave1 582 Jul 30 11:50 .ssh/authorized_keys

$ sudo usermod -aG wheel jenkins-slave1
$ id jenkins-slave1

Jenkins Master Node (Copy slave node’s public key to master node’s known_hosts file)
>vagrant ssh vg-compute-10
$ sudo mkdir -p /var/lib/jenkins/.ssh
$ cd /var/lib/jenkins
$ sudo chmod 777 .ssh
$ cd .ssh
$ sudo ssh-keyscan -H 192.168.20.19 >>/var/lib/jenkins/.ssh/known_hosts
# 192.168.20.19:22 SSH-2.0-OpenSSH_8.0
# 192.168.20.19:22 SSH-2.0-OpenSSH_8.0
# 192.168.20.19:22 SSH-2.0-OpenSSH_8.0
$ sudo chown jenkins:jenkins known_hosts
$ sudo chmod 700 known_hosts
$ ls -lai known_hosts
35254578 -rwx------. 1 jenkins jenkins 978 Jul 30 11:56 known_hosts

Jenkins Web Console

http://192.168.20.18:8080/
Menuge Jenkins - Manage Nodes and Clouds - New Node - vg-compute-11 - Permanent Agent
Description  slave1
Remote root directory /home/jenkins-slave1
Labels vg-compute-11
Launch method Launch agents via SSH
Host 192.168.20.19
Add Jenkins
Kind SSH Username with private key
Username jenkins-slave1
Private Key - Enter directly - Add
Credentials jenkins-slave1 (Top down menu)
Save

Copy user private key on Jenkins Slave Node
[jenkins-slave1@vg-compute-11 tmp]$ cd ~
[jenkins-slave1@vg-compute-11 ~]$ pwd
/home/jenkins-slave1
[jenkins-slave1@vg-compute-11 ~]$ cat .ssh/id_rsa

Jenkins Web Console
Paste pivate key and Save
~~~~
~~~~

Jenkins Slave Node(Ubuntu 20.04)

vagrant up  vg-compute-12
vagrant ssh vg-docker-12 (password:vagrant)
$ whoami
vagrant
$ sudo useradd jenkins-slave2 -s /bin/bash -g sudo -m
$ sudo su - jenkins-slave2
$ ssh-keygen -t rsa -N "" -f /home/jenkins-slave2/.ssh/id_rsa
$ cd .ssh 
$ cat id_rsa.pub > authorized_keys 
$ chmod 700 authorized_keys

Jenkins Master Node (Copy slave node’s public key to master node’s known_hosts file)
>vagrant ssh vg-compute-10
[vagrant@vg-compute-10 jenkins]$ cd /var/lib/jenkins/.ssh
$ sudo ssh-keyscan -H 192.168.20.20 | sudo tee - a /var/lib/jenkins/.ssh/known_hosts

Jenkins Web Console

http://192.168.20.18:8080/
Menuge Jenkins - Manage Nodes and Clouds - New Node - vg-compute-11 - Permanent Agent
Description  vg-compute-12
Remote root directory /home/jenkins-slave2
Labels vg-compute-12
Launch method Launch agents via SSH
Host 192.168.20.19
Add Jenkins
Kind SSH Username with private key
Username jenkins-slave1
Private Key - Enter directly - Add
Credentials jenkins-slave2(Top down menu)
Save
~~~~
~~~~

[vagrant@vg-compute-10 .ssh]$  which ansible
/usr/bin/ansible

Jenkins Web Console

http://192.168.20.18:8080/
Global Tool Configuration 
Ansible - Ansible installations - Add Ansible
Name ansible
Path to ansible executables directory /usr/bin
Save
~~~~
~~~~
Dashboard - New Item - Pipeline
elk-ansible-pipeline
~~~~
~~~~
"Building on the controller node can be a security issue. You should set the number of executors on the controller to 0. "
Manage - Number of executors=0

~~~~
