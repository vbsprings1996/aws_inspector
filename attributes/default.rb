# Used in aws_inspector_user.rb recipe
default['aws_inspector']['user'] = 'hosting'
default['aws_inspector']['group'] = 'hosting'

# Used in download_aws_inspector.rb Recipe
default['aws_inspector']['install_script_url'] = 'https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install'

# Used in aws_inspector_install_script_gpg_signature_validation.rb recipe.
default['aws_inspector']['install_script_gpg_public_key'] = 'https://d1wk0tztpsntt1.cloudfront.net/linux/latest/inspector.gpg'
default['aws_inspector']['install_script_gpg_signature_file'] = 'https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install.sig'
