#!/bin/sh
set -o xtrace
sudo -i
apt update
cd ~
export CHEFDKVER=4.13.3
wget https://packages.chef.io/files/stable/chefdk/${CHEFDKVER}/ubuntu/20.04/chefdk_${CHEFDKVER}-1_amd64.deb
apt -y install ./chefdk_${CHEFDKVER}-1_amd64.deb
apt -y install git-all

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

export DOCKER_COMPOSE_VER=2.1.1
curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VER}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

git clone https://github.com/EliranKasif/CloudSchool-DEVOPS.git

cd /CloudSchool-DEVOPS/DockerCompose/MainInstance

docker-compose up --detach

docker exec -i vault-server bin/sh < vault_init_database.sh





