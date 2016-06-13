#
# Cookbook Name:: aws_inspector
# Recipe:: aws_inspector_install_script_gpg_signature_validation
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install gpg package, if it doesn't exist.
package 'install_gpg' do
  case node[:platform]
  when 'centos', 'redhat', 'amazon', 'scientific', 'oracle'
    package_name 'gpg'
  when 'ubuntu', 'debian'
    package_name 'gnupg'
  end
end

# AWS inspector gpg public key path.
aws_inspector_gpg_public_key_path = "#{node.default['aws_inspector']['resources_download_dir']}/#{node.default['aws_inspector']['gpg_public_key']}"
# Download aws_inspector gpg public key.
remote_file aws_inspector_gpg_public_key_path do
  source node.default['aws_inspector']['install_script_gpg_public_key']
  owner node.default['aws_inspector']['group']
  group node.default['aws_inspector']['group']
  mode '0755'
end


# Import the downloaded aws_inspector public key.
ruby_block "gpg_import_public_key_and_store_key_value" do
    block do
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
        gpg_command = "gpg --import #{aws_inspector_gpg_public_key_path}"
        shell_out(gpg_command)
    end
    action :run
end

# Verify that the import key belongs to Amazon.
ruby_block "gpg_verify_aws_inspector_fingerprint" do
    block do
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
        gpg_command = "gpg --fingerprint $(gpg --list-keys 'Amazon' | head -1 | cut -d '/' -f2 | cut -d ' ' -f1) | grep -i fingerprint | cut -d '=' -f2 | sed 's/^ //'"
        gpg_command_out = shell_out(gpg_command)

        puts "\n INFO: ***gpg_command_out.stdout : #{gpg_command_out.stdout}"
        if gpg_command_out.stdout =~ /DDA0 D4C5 10AE 3C20 6F46  6DC0 2474 0960 5836 0418/
          puts "\n INFO: aws_inspector public key finger print matched."
        else
          raise "\n ERROR: aws_inspector public key finger print did not match."
        end
    end
    action :run
end

aws_inspector_install_script_signature_path = "#{node.default['aws_inspector']['resources_download_dir']}/#{node.default['aws_inspector']['install_script_sig']}"
# Download aws_inspector install script signature file.
remote_file aws_inspector_install_script_signature_path do
  source node.default['aws_inspector']['install_script_gpg_signature_file']
  owner node.default['aws_inspector']['group']
  group node.default['aws_inspector']['group']
  mode '0755'
end

# Verify aws_inspector install script signature.
ruby_block "gpg_verify_aws_inspector_install_script_signature" do
    block do
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)
        gpg_command = "gpg --verify #{aws_inspector_install_script_signature_path} 2>&1 | grep -i 'Amazon' | grep -i 'good'"
        gpg_command_out = shell_out(gpg_command)
        puts "\nINFO: ***gpg_command_out.stdout : #{gpg_command_out.stdout}"
        if gpg_command_out.stdout =~ /Good signature/
          puts "\n INFO: aws_inspector install script signature matched, now we can proceed with aws_inspector installation."
        else
          raise "\n ERROR: aws_inspector install script signature didn't match. We will stop aws_inspector installation"
        end
    end
    action :run
end
