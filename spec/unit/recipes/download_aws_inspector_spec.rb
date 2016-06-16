#
# Cookbook Name:: aws_inspector
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aws_inspector::download_aws_inspector' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do
         Chef::Config[:file_cache_path] = '/var/tmp' # ensure sanity when using remote_file resource
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'downloads the aws inspector install script' do
      expect(chef_run).to create_remote_file('/var/tmp/aws_inspector_install').with(mode: '0750', retries: 3)
    end

    it 'calls the gpg verification recipe' do
      expect(chef_run).to include_recipe('aws_inspector::aws_inspector_install_script_gpg_signature_validation')
    end


  end
end
