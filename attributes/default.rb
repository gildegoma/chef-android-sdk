default['android-sdk']['name']                      = 'android-sdk'
default['android-sdk']['owner']                     = 'root'
default['android-sdk']['group']                     = 'root'
default['android-sdk']['backup_archive']            = false # The number of backups to be kept in /var/chef/backup. To prevent backups set to false.
default['android-sdk']['setup_root']                = nil   # ark defaults (/usr/local) is used if this attribute is not defined
default['android-sdk']['with_symlink']              = true  # use ark's :install action when true; use ark's :put action when false
default['android-sdk']['set_environment_variables'] = true

default['android-sdk']['version']                   = '24.4'
default['android-sdk']['checksum']['linux']         = 'f2bb546534d16e2004665257ee530060338c684adad14a49cd4bbde08098d8a4'
default['android-sdk']['checksum']['mac_os_x']      = 'a1cb0c9b2036d597e18986de1bd43918b6113373ff3bf6fdb81b6cce4ec3efd7'
default['android-sdk']['checksum']['windows']       = '1f9f22271fe55bf0bf10b60556ed1a5fa2f2ca672fc20d35478325104941cb05'
default['android-sdk']['download_url']['linux']     = "http://dl.google.com/android/android-sdk_r#{node['android-sdk']['version']}-linux.tgz"
default['android-sdk']['download_url']['mac_os_x']  = "https://dl.google.com/android/android-sdk_r#{node['android-sdk']['version']}-macosx.zip"
default['android-sdk']['download_url']['windows']   = "https://dl.google.com/android/android-sdk_r#{node['android-sdk']['version']}-windows.zip"

#
# List of Android SDK components to preinstall:
# Selection based on
# - Platform usage statistics (see http://developer.android.com/about/dashboards/index.html)
# - Build Tools releases: http://developer.android.com/tools/revisions/build-tools.html
#
# Hint:
# Add 'tools' to the list below if you wish to get the latest version,
# without having to adapt 'version' and 'checksum' attributes of this cookbook.
# Note that it will require (waste) some extra download effort.
#
default['android-sdk']['components']                = %w( platform-tools
                                                          build-tools-24.0.1
                                                          android-24
                                                          sys-img-armeabi-v7a-android-24
                                                          sys-img-armeabi-v7a-android-tv-24
                                                          extra-android-support
                                                          extra-google-google_play_services
                                                          extra-google-m2repository
                                                          extra-android-m2repository )

default['android-sdk']['license']['white_list']     = %w(.+)
default['android-sdk']['license']['black_list']     = []    # e.g. ['intel-.+', 'mips-.+', 'android-wear-sdk-license-.+']
default['android-sdk']['license']['default_answer'] = 'n'   # 'y' or 'n' ('yes' or 'no')

default['android-sdk']['scripts']['path']           = '/usr/local/bin'
default['android-sdk']['scripts']['owner']          = node['android-sdk']['owner']
default['android-sdk']['scripts']['group']          = node['android-sdk']['group']

default['android-sdk']['java_from_system']          = false

default['android-sdk']['maven-rescue']              = false
