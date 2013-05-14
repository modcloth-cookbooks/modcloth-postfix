#
# Cookbook Name:: postfix
# Recipe:: default
#
# Copyright ModCloth, Inc.
#
# All rights reserved - Do Not Redistribute
#

case node["platform"]
when 'smartos'
  include_recipe "postfix::smartos"
else
  include_recipe "postfix::ubuntu"
end

