# Encoding: utf-8

require_relative 'spec_helper'

# NTP
puts os[:family]
if os[:family].downcase == 'centos'
  ntp_service = 'ntp'
else
  ntp_service = 'ntpd'
end

describe service(ntp_service) do
  it { should be_enabled }
  it { should be_running }
end
describe file('/etc/ntp.conf') do
  it { should be_file }
end
# rubocop:disable
describe command('diff /etc/localtime /usr/share/zoneinfo/Australia/Sydney') do
  its(:exit_status) { should eq 0 }
end
# rubocop:enable
