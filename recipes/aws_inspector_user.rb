#
# Cookbook Name:: aws_inspector
# Recipe:: aws_inspector_user
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

#Creating the group 'hosting'. Currently hard coding but refactor the code.

group 'hosting' do
end

###Creating the user 'hosting'. Currently hard coding but refactor the code.
#Defining 'user' home directory.
user 'hosting' do
  group 'hosting'
  shell '/bin/bash'
  comment 'aws inspector user'
end
