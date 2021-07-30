# jenkins-elk-sandbox


Official Jenkins Docker
~~~~
del Vagrantfile
vagrant init --template Vagrantfile.erb 
vagrant up vg-compute-12
vagrant ssh vg-docker-12 (password:vagrant)
del Vagrantfile
vagrant init --template Vagrantfile.erb 
vagrant up vg-compute-12
vagrant ssh vg-docker-12 (password:vagrant)

Browse
http://192.168.20.20:8080/

sudo docker version
sudo docker image prune --force
sudo docker pull jenkins/jenkins:lts-jdk11
sudo docker image ls
sudo docker run -d -p 8080:8080 --name jenkinsci jenkins/jenkins:lts-jdk11 
sudo docker exec $(docker ps -q) cat /var/jenkins_home/secrets/initialAdminPassword
sudo docker container ls
sudo docker container stop jenkinsci
sudo docker container prune --force

http://192.168.20.11:8080

add plugins
configuration-as-code
ansible

Plugin list (export default list)
Script Console(Groovy)
http://192.168.20.11:8080/script

Jenkins.instance.pluginManager.plugins.each{
  plugin ->
    println ("${plugin.getShortName()}")
}