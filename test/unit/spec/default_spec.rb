# Encoding: utf-8

require_relative 'spec_helper'

describe 'rackspace_anz_dd15demo::default' do
  before do
    stub_resources
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(CENTOS_OPTS) do |node|
      node.set['public_info']['remote_ip'] = '10.10.10.10'
      stub_resources
      # Stub the node and any calls to Environment.Load to return this environment
      env = Chef::Environment.new
      env.name 'devel'
      allow(node).to receive(:chef_environment).and_return(env.name)
      allow(Chef::Environment).to receive(:load).and_return(env)
    end.converge(described_recipe)
  end
end
