default['android-sdk']['name']           = 'android-sdk'
default['android-sdk']['owner']          = 'root'
default['android-sdk']['group']          = 'root'
default['android-sdk']['setup_root']     = nil  # ark defaults (/usr/local) is used if this attribute is not defined

default['android-sdk']['version']        = '22.2.1'
default['android-sdk']['checksum']       = '17ea4610008985eb1454b3b25ad00c59300cee3141f7ea3deec98f45d862faa5'

default['android-sdk']['download_url']   = "http://dl.google.com/android/android-sdk_r#{node['android-sdk']['version']}-linux.tgz"

# List of Android SDK components to preinstall:
default['android-sdk']['components']     = %w(platform-tools build-tools-18.0.1 android-18 sysimg-18 android-17 sysimg-17 android-16 sysimg-16 extra-android-support extra-google-google_play_services extra-google-m2repository extra-android-m2repository)
