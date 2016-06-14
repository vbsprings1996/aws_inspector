#require 'spec_helper'

#describe 'aws_inspector::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
#  it 'Downloads aws_inspector install script and installs it' do
#    skip 'Replace this with meaningful tests'
#  end
#end

describe command('/etc/init.d/awsagent status') do
  its('stdout') { should match /Agent version/i }
  its('stdout') { should match /Registered/i}
  its('stdout') { should match /AgentId/i}
  its('stdout') { should_not match /failed/i}
  its('exit_status') { should eq 0 }
end
