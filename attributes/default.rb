# Used in aws_inspector_user.rb recipe
default['aws_inspector']['user'] = 'hosting'
default['aws_inspector']['group'] = 'hosting'

# Used in download_aws_inspector.rb Recipe
default['aws_inspector']['install_script_url'] = 'https://d1wk0tztpsntt1.cloudfront.net/linux/latest/install'
