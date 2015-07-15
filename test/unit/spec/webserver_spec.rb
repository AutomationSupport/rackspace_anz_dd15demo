# Encoding: utf-8

require_relative 'spec_helper'

describe 'rackspace_anz_dd15demo::webserver' do
  before do
    stub_resources
  end

  cached(:chef_run) do
    ChefSpec::SoloRunner.new(CENTOS_OPTS) do |node|
      node.set['public_info']['remote_ip'] = '10.10.10.10'
      # Stub the node and any calls to Environment.Load to return this environment
      env = Chef::Environment.new
      env.name 'devel'
      allow(node).to receive(:chef_environment).and_return(env.name)
      allow(Chef::Environment).to receive(:load).and_return(env)
      allow(File).to receive(:exist?).and_call_original
    end.converge(described_recipe)
  end

  # it 'should include dependent recipes' do
  #   included_recipes = [
  #     'apache::default'
  #   ]
  #   included_recipes.each do |recipe|
  #     expect(chef_run).to include_recipe(recipe)
  #   end
  # end

  # it 'should create siso user' do
  #   expect(chef_run).to create_user('siso')
  #   expect(chef_run).to lock_user('siso')
  # end
end
