FROM amazonlinux:latest

ARG packer_version=1.4.0
ARG ansible_version=2.7.*

USER root

RUN yum update -y && yum install -y python3 python3-pip python-boto3 jq wget unzip git sudo zip openssl which java-1.8.0-openjdk-devel.x86_64
RUN cp /usr/bin/python3 /usr/bin/python
RUN cp /usr/bin/pip3 /usr/bin/pip

RUN groupadd sudo && adduser art -g sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN pip install pip --upgrade
RUN pip install credstash boto ansible==${ansible_version}

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &&\
    unzip awscliv2.zip &&\
    sudo ./aws/install


# Install Packer
RUN wget https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip -O packer.zip &&\
    unzip packer.zip &&\
    mv packer /usr/sbin/packer &&\
    chmod 755 /usr/sbin/packer

# Install Kotlin
RUN curl -s https://get.sdkman.io | bash &&\
    source "/root/.sdkman/bin/sdkman-init.sh" &&\
    sdk install kotlin

RUN rm -f /bin/sh && ln -s /bin/bash /bin/sh
RUN rm /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Seoul /etc/localtime

USER art
