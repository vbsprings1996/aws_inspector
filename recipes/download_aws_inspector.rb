#
# Cookbook Name:: aws_inspector
# Recipe:: download_aws_inspector
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Download the install script to /tmp/install

# Currently '/tmp/install' is hardcoded, should we create attribute for this too?
remote_file '/tmp/install' do
  source node.default['aws_inspector']['install_script_url']
  owner node.default['aws_inspector']['group']
  group node.default['aws_inspector']['group']
  mode '0755'
end
