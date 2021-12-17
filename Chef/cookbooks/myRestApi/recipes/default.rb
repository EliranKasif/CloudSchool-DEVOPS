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
  shell '/bin/bash'
  password '$1$alilbito$C83FsODuq0A1pUMeFPeR10'
end

git "/CloudSchool-DEVOPS/Chef/cookbooks/myRestApi/files/default/myapp" do
  repository "git://github.com/EliranKasif/CloudSchool-PythonRestApi.git"
  reference "main"
  action :sync
end

remote_directory '/home/bob/myapp' do
  source 'myapp' # This is the name of the folder containing our source code that we kept in ./my-cookbook/files/default/
  owner 'bob'
  group 'users'
  mode '0755'
  action :create
end

execute 'install python dependencies' do
  command 'pip3 install -r /code/requirements.txt'
  cwd '/home/bob/myapp'
end

bash 'run consul-installation.sh and start consul-template' do
  cwd '$HOME/'
  code <<-EOH 
    consul-template -config /CloudSchool-DEVOPS/DockerCompose/WorkerInstance/consul-config.hcl &
  EOH
end

