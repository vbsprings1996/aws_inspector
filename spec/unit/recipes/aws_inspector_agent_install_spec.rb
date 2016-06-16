#
# Cookbook Name:: aws_inspector
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'aws_inspector::aws_inspector_agent_install' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'aws inspector agent install' do
        expect(chef_run).to run_execute('aws inspector agent install')
    end

    it 'enables the awsagent service' do
        expect(chef_run).to enable_service('awsagent')
    end
    
  end
end
