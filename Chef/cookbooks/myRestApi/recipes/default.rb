#
# Cookbook:: myRestApi
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

template "var/www/html/index.html" do
    source node["apache"]["indexfile"]
    mode "0644"
  end
