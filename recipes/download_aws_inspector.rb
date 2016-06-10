#
# Cookbook Name:: aws_inspector
# Recipe:: download_aws_inspector
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Currently '/tmp/install' is hardcoded, should we create attribute for this too?
aws_inspector_install_script_path = "#{node.default['aws_inspector']['resources_download_dir']}/#{node.default['aws_inspector']['install_script']}"

# Download the install script to /tmp/install
aws_inspector_install_script_path = "#{node.default['aws_inspector']['resources_download_dir']}/#{node.default['aws_inspector']['install_script']}"
remote_file aws_inspector_install_script_path do
  source node.default['aws_inspector']['install_script_url']
  owner node.default['aws_inspector']['group']
  group node.default['aws_inspector']['group']
  mode '0755'
end
