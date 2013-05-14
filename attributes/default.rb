#
# Cookbook Name:: postfix
# Attributes:: default
#
# Copyright ModCloth, Inc.
#
# All rights reserved - Do Not Redistribute
#

default[:postfix][:inet_interfaces]         = 'loopback-only'
default[:postfix][:mynetworks]              = '$myhostname, 127.0.0.0/8'
default[:postfix][:relay_host]              = '[mailhost-01.prod.modcloth.com]:25'
default[:postfix][:smtp_sasl_user_pass]     = ''
