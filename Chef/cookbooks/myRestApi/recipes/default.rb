#
# Cookbook:: myRestApi
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

apt_update
package 'python3'
package 'python3-pip'
package 'pkg-config'
package 'libcairo2-dev'
package 'libjpeg-dev'
package 'libgif-dev'
package 'libgirepository1.0-dev'
package 'libmysqlclient-dev'
package 'git'

user 'bob' do
  uid 1212
  gid 'users'
  home '/home/bob'
  manage_home true
  shell '/bin/bash'
  password '$1$alilbito$C83FsODuq0A1pUMeFPeR10'
end

directory "/home/bob/myapp" do
  owner 'bob'
  group 'users'
  mode '0755'
  ignore_failure true
  action :create
end

git "/home/bob/myapp" do
  repository "git://github.com/EliranKasif/CloudSchool-PythonRestApi.git"
  reference "main"
  retries 3
  action :sync
end

execute 'install python dependencies' do
  command 'pip3 install -r requirements.txt'
  cwd '/home/bob/myapp'
end

execute 'run consul-template to get application config' do
  cwd '/CloudSchool-DEVOPS/DockerCompose/WorkerInstance/'
  command 'consul-template -config ./consul-config.hcl &'
  timeout 10         
end

execute 'run application' do
  cwd '/home/bob/myapp'
  command 'python3 app.py'
end

