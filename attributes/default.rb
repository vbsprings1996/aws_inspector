default['aws_inspector']['inspector_url_base'] = 'https://d1wk0tztpsntt1.cloudfront.net/linux/latest'

# Used in aws_inspector_user.rb recipe
default['aws_inspector']['user'] = 'awsinspector'
default['aws_inspector']['group'] = 'awsinspector'

# Used in download_aws_inspector.rb Recipe
default['aws_inspector']['install_script_url'] = "#{node['aws_inspector']['inspector_url_base']}/install"
default['aws_inspector']['resources_download_dir'] = Chef::Config[:file_cache_path]
default['aws_inspector']['install_script'] = 'aws_inspector_install'

# Used in aws_inspector_install_script_gpg_signature_validation.rb recipe.
default['aws_inspector']['gpg_public_key'] = 'inspector.gpg'
default['aws_inspector']['install_script_gpg_public_key'] = "#{node['aws_inspector']['inspector_url_base']}/#{node['aws_inspector']['gpg_public_key']}"
default['aws_inspector']['install_script_gpg_signature_file'] = "#{node['aws_inspector']['inspector_url_base']}/install.sig"
default['aws_inspector']['install_script_sig'] = "#{node['aws_inspector']['install_script']}.sig"
