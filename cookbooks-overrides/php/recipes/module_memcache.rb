#
# Author::  Joshua Timberman (<joshua@opscode.com>)
# Author::  Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: php
# Recipe:: module_memcache
#
# Copyright 2009-2011, Opscode, Inc.
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

case node['platform']
when "centos", "redhat", "fedora"
  pkgs = %w{ zlib-devel }
when "debian", "ubuntu"
  pkgs = %w{ zlib1g-dev }
end

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

php_pear "memcache" do
  version "2.2.0"
  action :install
  directives({
    :dbpath                => "/var/lib/memcache",
    :maxreclevel           => 0,
    :maxfiles              => 0,
    :archivememlim         => 0,
    :maxfilesize           => 0,
    :maxratio              => 0,
    :allow_failover        => true,
    :max_failover_attempts => 20,
    :chunk_size            => 32768,
    :default_port          => 11211,
    :hash_strategy         => "consistent",
    :hash_function         => "crc32",
    :redundancy            => 1,
    :session_redundancy    => 2
  })
end
