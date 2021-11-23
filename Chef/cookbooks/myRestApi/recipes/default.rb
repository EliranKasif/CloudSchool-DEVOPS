#
# Cookbook:: myRestApi
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

package "python" do 
  action :install
end

template "/tmp/app/CloudSchool-DEVOPS/PythonRestApi/code/config/app.conf" do
  source node["myRestApi"]["configfile"]
  mode "0644"
end
