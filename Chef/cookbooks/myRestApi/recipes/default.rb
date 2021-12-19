#
# Cookbook:: myRestApi
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

apt_update
package 'python3'
package 'python3-pip'
package 'pkg-config'
package 'build-essential'
package 'libssl-dev'
package 'libffi-dev'
package 'libgirepository1.0-dev'
package 'libmysqlclient-dev'
package 'git'
package 'gunicorn3'

user 'bob' do
  uid 1212
  gid 'users'
  home '/home/bob'
  manage_home true
  shell '/bin/bash'
  password '$1$alilbito$C83FsODuq0A1pUMeFPeR10'
  action [:create, :modify]
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

systemd_unit 'gunicorn.service' do
  content({
  Unit: {
    Description: 'Flask on Gunicorn',
    After: 'network.target',
  },
  Service: {
    ExecStart: '/usr/local/bin/gunicorn --workers 3 --bind localhost:5000 app.py:app',
    User: 'bob',
    Group: 'www-data',
    WorkingDirectory: '/home/bob/myapp',
    Restart: 'always'
  },
  Install: {
    WantedBy: 'multi-user.target',
  }
  })
  action [:create, :enable, :start]
end

