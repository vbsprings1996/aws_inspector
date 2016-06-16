#
# Cookbook Name:: aws_inspector
# Recipe:: aws_inspector_agent_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# AWS inspector install script path.
aws_inspector_install_script_path = ::File.join(
  ::File::SEPARATOR, node.default['aws_inspector']['resources_download_dir'], node.default['aws_inspector']['install_script']
)

# Install aws_inspector agent.
execute 'aws inspector agent install' do
  command aws_inspector_install_script_path
  notifies :restart, 'service[awsagent]', :immediately
end

service 'awsagent' do
  action :enable
end
