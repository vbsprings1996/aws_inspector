#
# Cookbook Name:: aws_inspector
# Recipe:: aws_inspector_agent_install
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install aws_inspector agent.
execute 'aws inspector agent install' do
  command 'bash /tmp/install'
end

#ruby_block "aws_inspector_agent_install" do
#    block do
#        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
#        aws_inspector_agent_install_command = "sudo bash /tmp/install"
#        aws_inspector_agent_install_command_out = shell_out(aws_inspector_agent_install_command)

#        puts "\n INFO: ***aws_inspector_agent_install_command_out.stdout : #{aws_inspector_agent_install_command_out.stdout}"
#        puts "\n INFO: aws agent had been installed."
#    end
#    action :run
#end

# Validate aws_inspector agent installation successful or not.
ruby_block "aws_inspector_agent_install_success_or_failure" do
    block do
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
        aws_inspector_agent_install_success_or_failure_command = "/etc/init.d/awsagent status"
        aws_inspector_agent_install_success_or_failure_command_out = shell_out(aws_inspector_agent_install_success_or_failure_command)

        puts "\n INFO: ***aws_inspector_agent_install_success_or_failure_command_out.stdout : #{aws_inspector_agent_install_success_or_failure_command_out.stdout}"
        if aws_inspector_agent_install_success_or_failure_command_out.stdout =~ /failed/
          raise "\n ERROR: aws_inspector agent installation failed."
        else
          puts "\n INFO: aws_inspector agent installation is successful."
        end
    end
    action :run
end
