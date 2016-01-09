#
# Cookbook Name:: git-client
# Recipe:: default
#
# Copyright (c) 2016 ᑎɑղօԹíϲօ(nanopico)

package "expect" do
  package_name 'expect'
  action :install
  not_if 'which expect'
end

package "git" do
  package_name 'git'
  action :install
  not_if 'which git'
end

package "lv" do
  package_name 'lv'
  action :install
  not_if 'which lv'
end

directory "#{node['git-client']['github-home-dir']}" do
  owner  node['git-client']['unix-user']
  group  node['git-client']['group']
  mode   '0755'
  action :create
end

if node['git-client']['enable-bitbucket-host'] then
  directory "#{node['git-client']['bitbucket-home-dir']}" do
    owner  node['git-client']['unix-user']
    group  node['git-client']['group']
    mode   '0755'
    action :create
  end
end

execute 'configure-git-dir' do
  cwd node['git-client']['git-home-dir']
  command <<-EOC
  git config --global user.name "#{node['git-client']['username']}"
  git config --global user.email "#{node['git-client']['email']}"
  git config --global push.default #{node['git-client']['push-default']}
  git config --global alias.logstat "#{node['git-client']['alias-stat']}"
  git config --global alias.diff "#{node['git-client']['alias-diff']}"
  git config --global color.ui #{node['git-client']['color-ui']}
  git config --global core.editor #{node['git-client']['core-editor']}
  git config --global core.pager "#{node['git-client']['core-pager']}"
  EOC
end

directory "#{node['git-client']['home-dir']}/.ssh" do
  owner  node['git-client']['unix-user']
  group  node['git-client']['group']
  mode   '0700'
  action :create
end

template '/#{Chef::Config[:file_cache_path]}/script.exp' do
  source 'script.exp.erb'
  owner  node['git-client']['unix-user']
  group  node['git-client']['group']
  mode   '0750'
  action :create
end

if node['git-client']['if-create-ssh-key'] then
  execute 'ssh-keygen' do
    cwd "#{node['git-client']['home-dir']}/.ssh"
    command <<-EOC
    /#{Chef::Config[:file_cache_path]}/script.exp
    chmod 0400 #{node['git-client']['ssh-key-filename']}
    EOC
    user  node['git-client']['unix-user']
    group node['git-client']['group']
  end
end

template "#{node['git-client']['home-dir']}/.ssh/config" do
  source "config.erb"
  owner  node['git-client']['unix-user']
  group  node['git-client']['group']
  mode   '0600'
  action :create_if_missing
end
