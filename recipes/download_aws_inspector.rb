#
# Cookbook Name:: aws_inspector
# Recipe:: download_aws_inspector
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# platform-independence
aws_inspector_install_script_path = ::File.join(
  ::File::SEPARATOR, node.default['aws_inspector']['resources_download_dir'], node.default['aws_inspector']['install_script']
)


# Download the install script to aws_inspector_install_script_path
remote_file aws_inspector_install_script_path do
  source node['aws_inspector']['install_script_url']
  owner  node['aws_inspector']['user']
  group  node['aws_inspector']['group']
  mode   '0750'
  retries 3
  retry_delay 5
end

# Include gpg signature validation recipe
include_recipe "#{cookbook_name}::aws_inspector_install_script_gpg_signature_validation"
