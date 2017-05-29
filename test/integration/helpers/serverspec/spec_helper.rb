require 'serverspec'

if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM).nil?
  set :backend, :exec
  set :path, '/sbin:/usr/local/sbin:/bin:/usr/local/bin:/usr/bin:/usr/local/android-sdk/platform-tools/:/usr/local/android-sdk/tools/:$PATH'
else
  set :backend, :cmd
  set :os, family: 'windows'
  set :path, 'C:\\Users\\vagrant\\google\\android-sdk\\platform-tools;C:\\Users\\vagrant\\google\\android-sdk\\tools'
end

::Dir[::File.join(::File.dirname(__FILE__), 'shared_serverspec_tests/*.rb')].sort.each { |f| require f }
