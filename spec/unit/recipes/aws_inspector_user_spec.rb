#
# Cookbook Name:: aws_inspector
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aws_inspector::aws_inspector_user' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'group is created successfully' do
        expect(chef_run).to create_group('awsinspector')
    end

    it 'user is created successfully' do
        expect(chef_run).to create_user('awsinspector').with(shell: '/sbin/nologin')
    end

  end
end
