#
# Cookbook Name:: aws_inspector
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aws_inspector::aws_inspector_install_script_gpg_signature_validation' do
  context 'aws inspector install script gpg signature validation : ' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'check gpg package exists, if not install it' do
        expect(chef_run).to install_package('install_gpg')
    end

    it 'download aws inspector public key' do
        expect(chef_run).to create_remote_file('/tmp/inspector.gpg')
    end

    it 'import aws inspector public key' do
        expect(chef_run).to run_ruby_block('gpg_import_public_key_and_store_key_value')
    end

    it 'verify the public key belongs to Amazon' do
        expect(chef_run).to run_ruby_block('gpg_verify_aws_inspector_fingerprint')
    end

    it 'download install script signature' do
        expect(chef_run).to create_remote_file('/tmp/install.sig')
    end

    # Should I assume file exists, because file was downloaded in 'download_aws_inspect.rb' recipe?
    # Or should I check again that file exists.
    it 'check /tmp/install script exists'

    it 'verify the aws_inspector install script signature' do
        expect(chef_run).to run_ruby_block('gpg_verify_aws_inspector_install_script_signature')
    end

  end
end
