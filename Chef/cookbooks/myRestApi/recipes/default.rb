#
# Cookbook:: myRestApi
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
template "../../../../PythonRestApi/code/config/app.conf" do
  source node["myRestApi"]["config"]
  mode "0644"
end
