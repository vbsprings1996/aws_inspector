#
# Cookbook Name:: aws_inspector
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Include 'aws_inspector_user.rb' recipe.
include_recipe 'aws_inspector::aws_inspector_user'

# Include 'download_aws_inspector.rb' recipe.
include_recipe 'aws_inspector::download_aws_inspector'

# Include 'aws_inspector_install_script_gpg_signature_validation.rb' recipe.
include_recipe 'aws_inspector::aws_inspector_install_script_gpg_signature_validation'
