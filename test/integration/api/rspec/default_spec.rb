# Encoding: utf-8

require_relative 'spec_helper'

describe port('22') do
  it { should be_listening }
end

describe port('80') do
  it { should be_listening }
end

describe file('/var/www') do
  it { should be_directory }
end
