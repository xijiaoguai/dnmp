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

curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose