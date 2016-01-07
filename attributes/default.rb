#
# Cookbook Name:: git-client
# Attributes:: default
#
# Copyright 2016, ᑎɑղօԹíϲօ(nanopico)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


default['git-client']['unix-user']             = 'user'
default['git-client']['home-dir']              = "/home/#{node['git-client']['unix-user']}"
default['git-client']['github-home-dir']       = "#{node['git-client']['home-dir']}/git"
default['git-client']['group']                 = #{node['git-client']['unix-user']}
default['git-client']['username']              = 'git-user'
default['git-client']['email']                 = 'your@email.com'
default['git-client']['push-default']          = 'tracking'
default['git-client']['alias-stat']            = 'log --stat --summary'
default['git-client']['alias-diff']            = 'diff -w'
default['git-client']['color-ui']              = 'auto'
default['git-client']['core-editor']           = 'vim'
default['git-client']['core-pager']            = 'lv -c'

default['git-client']['if-create-ssh-key']     = true
default['git-client']['ssh-key-filename']      = "id_rsa.#{node['git-client']['username']}"

default['git-client']['enable-bitbucket-host'] = true
default['git-client']['bitbucket-home-dir']    = "#{node['git-client']['home-dir']}/git"
default['git-client']['bitbucket-username']    = 'bitbucket-user'
