#!/bin/bash -ex

function waitForJenkins() {
    echo "Waiting jenkins to launch on 8080..."

    while ! nc -z localhost 8080; do
      sleep 0.1 # wait for 1/10 of the second before check again
    done

    echo "Jenkins launched"
}

function waitForPasswordFile() {
    echo "Waiting jenkins to generate password..."

    while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]; do
      sleep 2 # wait for 1/10 of the second before check again
    done

    echo "Password created"
}


yum update -y

yum install -y jq git awscli nmap-ncat nfs-common java-17-amazon-corretto


export JENKINS_HOME=/var/lib/jenkins
mkdir -p $JENKINS_HOME

mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_dns_name}:/ $JENKINS_HOME

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum upgrade

sleep 5

yum install -y jenkins

sed -i 's/Djava.awt.headless=true/Djava.awt.headless=true -Xmx2G -Xms2G -Dorg.apache.commons.jelly.tags.fmt.timeZone=Asia\/Seoul/g' /etc/sysconfig/jenkins

service jenkins start
