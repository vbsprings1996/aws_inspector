#
# Cookbook Name:: aws_inspector
# Recipe:: aws_inspector_install_script_gpg_signature_validation
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install gpg package, if it doesn't exist.
package 'install_gpg' do
  package_name 'gnupg'
end

# AWS inspector gpg public key path.
aws_inspector_gpg_public_key_path = ::File.join(
  ::File::SEPARATOR, node['aws_inspector']['resources_download_dir'], node['aws_inspector']['gpg_public_key']
  )

# Download aws_inspector gpg public key.
remote_file aws_inspector_gpg_public_key_path do
  source node['aws_inspector']['install_script_gpg_public_key']
  owner  node['aws_inspector']['group']
  group  node['aws_inspector']['group']
  mode   '0640'
  retries 3
  retry_delay 5
end


# Import the downloaded aws_inspector public key.
execute "import inspector gpg key" do
  command "gpg --import #{aws_inspector_gpg_public_key_path}"
end

# Verify that the import key belongs to Amazon.
ruby_block "verify inspector gpg key" do
    block do
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)

        # expect to match 'DDA0 D4C5 10AE 3C20 6F46  6DC0 2474 0960 5836 0418' (http://rubular.com/r/aEE62xtOwe)
        fp_re = Regexp.new('^\s*DDA0\s+D4C5\s+10AE\s+3C20\s+6F46\s+6DC0\s+2474\s+0960\s+5836\s+0418\s*$')

        # Fetch the key id
        key_id_cmd = "gpg --list-keys 'Amazon Inspector' | grep -i ^pub | awk '{print $2}' | cut -d '/' -f 2"
        Chef::Log.debug('Executing command: %s' % key_id_cmd)
        key_id = shell_out(key_id_cmd).stdout.chomp

        # Fetch the fingerprint.
        key_fp_cmd = "gpg --fingerprint #{key_id} | grep -i fingerprint | cut -d '=' -f 2"
        Chef::Log.debug('Executing command: %s' % key_fp_cmd)
        key_fp = shell_out(key_fp_cmd).stdout.chomp

        #Validate if public key fingerprint matches.
        Chef::Log.info("*** Inspector public key fingerprint: %s" % key_fp)
        if fp_re.match(key_fp)
          Chef::Log.info("Inspector public key fingerprint matches")
        else
          msg = 'Inspector public key mismatch!'
          Chef::Log.fatal(msg)
          raise msg
        end
    end
    action :run
end


# Download aws_inspector install script signature file.
aws_inspector_install_script_signature_path = ::File.join(
  ::File::SEPARATOR, node['aws_inspector']['resources_download_dir'], node['aws_inspector']['install_script_sig']
)

remote_file aws_inspector_install_script_signature_path do
  source node['aws_inspector']['install_script_gpg_signature_file']
  owner  node['aws_inspector']['group']
  group  node['aws_inspector']['group']
  mode   '0640'
  retries 3
  retry_delay 5
end

# Verify aws_inspector install script signature.
ruby_block "verify inspector install script signature" do
    block do
        Chef::Resource::RubyBlock.send(:include, Chef::Mixin::ShellOut)

        # http://rubular.com/r/mLbIC3GR51
        verify_re = Regexp.new("good\s+signature\s+.*Amazon\s+Inspector", Regexp::IGNORECASE)

        gpg_cmd = "gpg --verify #{aws_inspector_install_script_signature_path} 2>&1 | grep -i 'Amazon inspector' | grep -i 'good signature'"
        Chef::Log.debug('Executing command: %s' % gpg_cmd)
        gpg_cmd_out = shell_out(gpg_cmd).stdout.chomp

        Chef::Log.info("*** install script signature verification output: %s" % gpg_cmd_out)
        if verify_re.match(gpg_cmd_out)
          Chef::Log.info("inspector install script signature verified")
        else
          msg = 'inspector install script signature verification FAILED!'
          Chef::Log.fatal(msg)
          raise msg
        end
    end
    action :run
end
