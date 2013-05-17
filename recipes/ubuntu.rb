#
# Cookbook Name:: postfix
# Recipe:: ubuntu
#
# Copyright ModCloth, Inc.
#
# All rights reserved - Do Not Redistribute
#

package 'postfix' do
  action :install
end

package 'mailutils' do
  action :install
end

service "postfix" do
  action :enable
  supports :enable => true, :disable => true, :restart => true
end

cookbook_file "/etc/postfix/selfsigned.pem" do
  source "selfsigned.pem"
  mode 0644 
end

cookbook_file "/etc/postfix/cacert.pem" do
  source "cacert.pem"
  mode 0644 
end

template "/etc/postfix/main.cf" do
  source "main.cf.erb"
  mode 0644 
  notifies :restart, "service[postfix]"
end

execute "postmap-sasl_passwd" do
  command "postmap /etc/postfix/sasl_passwd"
  action :nothing
end

execute "postmap-generic" do
  command "postmap /etc/postfix/generic"
  action :nothing
end

execute "postmap-aliases" do
  command "postmap /etc/postfix/aliases"
  action :nothing
end

execute "postmap-canonical" do
  command "postmap /etc/postfix/canonical"
  action :nothing
end

execute "postmap-recipient_canonical" do
  command "postmap /etc/postfix/recipient_canonical"
  action :nothing
end

execute "postmap-sender_canonical" do
  command "postmap /etc/postfix/sender_canonical"
  action :nothing
end

execute "postmap-virtual" do
  command "postmap /etc/postfix/virtual"
  action :nothing
end

template "/etc/postfix/sasl_passwd" do
  source "sasl_passwd.erb"
  owner "root"
  group "root"
  mode 0400 
  notifies :run, resources(:execute => "postmap-sasl_passwd"), :immediately
  notifies :restart, resources(:service => "postfix")
end

cookbook_file "/etc/postfix/generic" do
  source "generic"
  notifies :run, resources(:execute => "postmap-generic"), :immediately
  notifies :restart, resources(:service => "postfix")
end

cookbook_file "/etc/postfix/aliases" do
  source "aliases"
  notifies :run, resources(:execute => "postmap-aliases"), :immediately
  notifies :restart, resources(:service => "postfix")
end

cookbook_file "/etc/postfix/canonical" do
  source "canonical"
  notifies :run, resources(:execute => "postmap-canonical"), :immediately
  notifies :restart, resources(:service => "postfix")
end

cookbook_file "/etc/postfix/recipient_canonical" do
  source "recipient_canonical"
  notifies :run, resources(:execute => "postmap-recipient_canonical"), :immediately
  notifies :restart, resources(:service => "postfix")
end

cookbook_file "/etc/postfix/sender_canonical" do
  source "sender_canonical"
  notifies :run, resources(:execute => "postmap-sender_canonical"), :immediately
  notifies :restart, resources(:service => "postfix")
end

cookbook_file "/etc/postfix/virtual" do
  source "virtual"
  notifies :run, resources(:execute => "postmap-virtual"), :immediately
  notifies :restart, resources(:service => "postfix")
end

