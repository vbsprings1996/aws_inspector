#
# Cookbook Name:: aws_inspector
# Recipe:: aws_inspector_user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#Creating the group 'hosting'. Currently hard coding but refactor the code.
group node.default['aws_inspector']['group'] do
end

###Creating the user 'hosting'. Currently hard coding but refactor the code.
#Defining 'user' home directory.
#user node.default['aws_inspector']['user'] do
user node.default['aws_inspector']['group'] do
  group node.default['aws_inspector']['group']
  shell '/bin/bash'
  comment 'aws inspector user'
end
