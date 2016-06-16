#
# Cookbook Name:: aws_inspector
# Recipe:: aws_inspector_user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Creating the group
group node.default['aws_inspector']['group']


### Creating the user
# Defining 'user' home directory.
# user node.default['aws_inspector']['user'] do
user node['aws_inspector']['group'] do
  group node['aws_inspector']['group']
  shell '/sbin/nologin'
  comment 'aws inspector user'
end
