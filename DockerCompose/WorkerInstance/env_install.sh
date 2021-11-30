#!/bin/sh
set -o xtrace
sudo -i
apt update
cd ~
export CHEFDKVER=4.13.3
wget https://packages.chef.io/files/stable/chefdk/${CHEFDKVER}/ubuntu/20.04/chefdk_${CHEFDKVER}-1_amd64.deb
apt -y install ./chefdk_${CHEFDKVER}-1_amd64.deb

apt -y install git-all

git clone https://github.com/EliranKasif/CloudSchool-DEVOPS.git

wget https://releases.hashicorp.com/consul-template/0.25.2/consul-template_0.25.2_linux_amd64.zip
unzip consul-template_0.25.2_linux_amd64.zip
sudo mv consul-template /usr/local/bin/

consul-template -config ~/CloudSchool-DEVOPS/DockerCompose/WorkerInstance/consul-config.hcl > consul-template.log 2> &1 &
