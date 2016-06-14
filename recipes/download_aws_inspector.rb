#
# Cookbook Name:: aws_inspector
# Recipe:: download_aws_inspector
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Create the directory if it doesn't exist.
directory node.default['aws_inspector']['resources_download_dir'] do
  owner node.default['aws_inspector']['user']
  group node.default['aws_inspector']['group']
  mode '0755'
  action :create
end

# Currently '/tmp/install' is hardcoded, should we create attribute for this too?
aws_inspector_install_script_path = "#{node.default['aws_inspector']['resources_download_dir']}/#{node.default['aws_inspector']['install_script']}"

# Download the install script to /tmp/install
remote_file aws_inspector_install_script_path do
  source node.default['aws_inspector']['install_script_url']
  owner node.default['aws_inspector']['user']
  group node.default['aws_inspector']['group']
  mode '0755'
end
