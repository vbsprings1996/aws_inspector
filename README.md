aws_inspector
=======
This cookbook installs AWS 'inspector' agent.

Requirements
------------
Operating System Requirements :- Currently, this cookbook is tested successfully for CentOS 7 only.
Amazon is working on bug fixes related to other OS.


Amazon Linux (2015.03 or later)

Ubuntu (14.04 LTS)

Red Hat Enterprise Linux (7.2)

Ubuntu (14.04 LTS)

CentOS (7.2)

Windows Server 2008 R2 and Windows Server 2012


Attributes
----------

default['aws_inspector']['inspector_url_base'] = 'https://d1wk0tztpsntt1.cloudfront.net/linux/latest'

default['aws_inspector']['user'] = 'awsinspector'

default['aws_inspector']['group'] = 'awsinspector'

default['aws_inspector']['install_script_url'] = "#{node['aws_inspector']['inspector_url_base']}/install"

default['aws_inspector']['resources_download_dir'] = Chef::Config[:file_cache_path]

default['aws_inspector']['install_script'] = 'aws_inspector_install'

default['aws_inspector']['gpg_public_key'] = 'inspector.gpg'

default['aws_inspector']['install_script_gpg_public_key'] = "#{node['aws_inspector']['inspector_url_base']}/#{node['aws_inspector']['gpg_public_key']}"

default['aws_inspector']['install_script_gpg_signature_file'] = "#{node['aws_inspector']['inspector_url_base']}/install.sig"

default['aws_inspector']['install_script_sig'] = "#{node['aws_inspector']['install_script']}.sig"


Usage
-----

#### aws_inspector::default

```json
{
  "name":"aws_inspector_node",
  "run_list": [
    "recipe[aws_inspector]"
  ]
}
```

License and Authors
-------------------
Authors:: Vijay Bheemineni(bheemineni.vijay@gmail.com)

Thanks
-------------------

Mike Morris

Bryan Bishop

Anshul Shrivastava

Bryan Anderson

Ryan Olsen

Craig McNeil

Jeff Schmidt 
