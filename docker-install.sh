#!/bin/bash
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

sudo yum makecache fast

sudo yum -y install docker-ce

sudo systemctl start docker

if [ ! -d /etc/docker ];then
mkdir /etc/docker
fi
touch /etc/docker/daemon.json && \
sudo tee /etc/docker/daemon.json <<-'EOF'
{
"registry-mirrors": ["https://kzflpq4b.mirror.aliyuncs.com"],
"insecure-registries": ["http://192.168.2.196"]
}
EOF

sudo rm /usr/local/bin/docker-compose

curl -L https://get.daocloud.io/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

sudo rm -rf /etc/init.d/docker.sh

sudo touch /etc/init.d/docker.sh

sudo chmod +x /etc/init.d/docker.sh

echo "sudo systemctl start docker" >> /etc/init.d/docker.sh
