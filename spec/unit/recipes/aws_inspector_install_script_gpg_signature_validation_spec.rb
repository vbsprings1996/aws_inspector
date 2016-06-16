#
# Cookbook Name:: aws_inspector
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aws_inspector::aws_inspector_install_script_gpg_signature_validation' do
  context 'aws inspector install script gpg signature validation : ' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do
         Chef::Config[:file_cache_path] = '/var/tmp' # ensure sanity when using remote_file resource
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'check gpg package exists, if not install it' do
        expect(chef_run).to install_package('install_gpg')
    end

    it 'download aws inspector public key' do
         expect(chef_run).to create_remote_file('/var/tmp/inspector.gpg').with(mode: '0640', retries: 3)
    end

    it 'import aws inspector public key' do
        expect(chef_run).to run_execute('import inspector gpg key')
    end

    it 'verify the public key belongs to Amazon' do
        expect(chef_run).to run_ruby_block('verify inspector gpg key')
    end

    it 'download install script signature' do
        expect(chef_run).to create_remote_file('/var/tmp/aws_inspector_install.sig').with(mode: '0640', retries: 3)
    end

    it 'verify the aws_inspector install script signature' do
        expect(chef_run).to run_ruby_block('verify inspector install script signature')
    end

  end
end
