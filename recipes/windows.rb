#
# Cookbook Name:: android-sdk
# Recipe:: windows
#
# Copyright 2011-2013, Travis CI Development Team <contact@travis-ci.org>
# Authors: Gilles Cornu
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

include_recipe 'ark::default'

setup_root       = node['android-sdk']['setup_root'].to_s.empty? ? node['ark']['prefix_home'] : node['android-sdk']['setup_root']
android_home     = File.join(setup_root, node['android-sdk']['name'])
android_bin      = File.join(android_home, 'tools', 'android.bat')

ark node['android-sdk']['name'] do
  url node['android-sdk']['download_url']['windows']
  path setup_root
  strip_components 0
  checksum node['android-sdk']['checksum']['windows']
  version node['android-sdk']['version']
  owner node['android-sdk']['owner']
  group node['android-sdk']['group']
  backup node['android-sdk']['backup_archive']
  action :unzip
end

ruby_block 'Rename directory' do
  block do
    if node['android-sdk']['legacy_sdk']
      ::File.rename "#{setup_root}/android-sdk-windows", "#{setup_root}/#{node['android-sdk']['name']}"
    else
      require 'fileutils'
      ::FileUtils.mkdir "#{setup_root}/#{node['android-sdk']['name']}"
      ::FileUtils.mv "#{setup_root}/tools", "#{setup_root}/#{node['android-sdk']['name']}/tools"
    end
  end
  only_if { ::Dir.exist?("#{setup_root}\\android-sdk-windows") || ::Dir.exist?("#{setup_root}\\tools") }
end

env 'ANDROID_HOME' do
  value android_home
  only_if { node['android-sdk']['set_environment_variables'] }
end

env 'PATH' do
  value "#{ENV['PATH']};%ANDROID_HOME%\\tools;%ANDROID_HOME%\\platform-tools"
  only_if { node['android-sdk']['set_environment_variables'] }
end

# KISS: use a basic idempotent guard, waiting for https://github.com/gildegoma/chef-android-sdk/issues/12
unless File.exist?("#{setup_root}/#{node['android-sdk']['name']}/temp")
  custom_environment = {
    'ANDROID_HOME' => android_home,
    'PATH' => "#{ENV['PATH']};#{node['expect']['cygwin']['home']}\\bin"
  }

  node['android-sdk']['components'].each do |sdk_component|
    kill_adb_command = "spawn #{android_home}/platform-tools/adb.exe kill-server" # adb freezes chef-client after installing platform-tools

    expect_script "Install Android SDK component #{sdk_component}" do
      cwd "#{android_home}/tools"
      environment custom_environment
      # TODO: use --force or not?
      code <<-EOH
            spawn #{android_bin} update sdk --no-ui --all --filter #{sdk_component}
            set timeout 180
            expect {
              -regexp "Do you accept the license '(#{node['android-sdk']['license']['white_list'].join('|')})'.*" {
                exp_send "y\r"
                exp_continue
              }
              -regexp "Do you accept the license '(#{node['android-sdk']['license']['black_list'].join('|')})'.*" {
                exp_send "n\r"
                exp_continue
              }
              "Do you accept the license '*-license-*'*" {
                exp_send "#{node['android-sdk']['license']['default_answer']}\r"
                exp_continue
              }
              "*Done. * package installed." {
                #{sdk_component == 'platform-tools' ? kill_adb_command : nil}
                exit
              }
              eof
            }
      EOH
    end
  end
end
