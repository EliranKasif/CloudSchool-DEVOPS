#
# Cookbook:: myRestApi
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

package "python" do 
  action :install
end

template "/tmp/app/CloudSchool-DEVOPS/PythonRestApi/code/config" do
  source node["myRestApi"]["config"]
  mode "0644"
end
