# Encoding: utf-8
require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :error
::CENTOS_OPTS = {
  platform: 'centos',
  version: '6.6',
  log_level: ::LOG_LEVEL
}

::CHEFSPEC_OPTS = {
  log_level: ::LOG_LEVEL
}

def stub_resources
  stub_command('which sudo').and_return(true)
  stub_command('dumpe2fs /dev/xvde1').and_return(false)
  stub_command('which nginx').and_return(0)
  stub_command("/usr/sbin/httpd -t").and_return(0)
  allow(Chef::EncryptedDataBagItem).to receive(:load).with('secrets', 'devel').and_return(f_databags('secrets', 'devel'))
  # For build domain helpers
  query = double(Chef::Search::Query)
  allow(Chef::Search::Query).to receive(:new).and_return(query)
  # allow(query).to receive(:search).with('node', 'tags:proxy_server AND chef_environment:devel')
  #   .and_return([[f_nodes('proxy')], 1, 1])
  # For build domain helpers
  query = double(Chef::Search::Query)
  allow(Chef::Search::Query).to receive(:new).and_return(query)
  # allow(query).to receive(:search).with('node', 'tags:proxy_server AND chef_environment:devel')
  #   .and_return([[f_nodes('proxy')], 1, 1])
  # allow(query).to receive(:search).with('node', 'tags:proxy_server AND chef_environment:devel')
  #   .and_return([[f_nodes('proxy')],  1, 1])
  # stub_command('curl -I --proxy http://192.168.111.114:3128 -m 10 http://google.com').and_return(false)
end

def stub_environments(server)
  Dir['./test/fixtures/environments/*.json'].sort.each do |f|
    env_data = JSON.parse(IO.read(f), symbolize_names: false)
    env_name = env_data['name']
    server.create_environment(env_name, env_data)
  end
end

def f_databags(databag = nil, item = nil)
  filepath = File.join('./test/fixtures/databags/', databag, "#{item}.json")
  JSON.parse(File.read(filepath))
end

def f_nodes(node = nil)
  filepath = File.join('./test/fixtures/nodes/', "#{node}.json")
  node_data = JSON.parse(File.read(filepath))
  stub_node(node, ohai: node_data['automatic'], file: filepath)
end

at_exit { ChefSpec::Coverage.report! }
