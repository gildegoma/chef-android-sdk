default['android-sdk']['name']                        = 'android-sdk'
default['android-sdk']['owner']                       = 'root'
default['android-sdk']['group']                       = platform_family?('mac_os_x') ? 'wheel' : 'root'
default['android-sdk']['backup_archive']              = false # The number of backups to be kept in /var/chef/backup. To prevent backups set to false.
default['android-sdk']['setup_root']                  = nil   # ark defaults (/usr/local) is used if this attribute is not defined
default['android-sdk']['with_symlink']                = true  # use ark's :install action when true; use ark's :put action when false
default['android-sdk']['set_environment_variables']   = true

default['android-sdk']['version']                     = '25.2.3'
default['android-sdk']['checksum']['linux']           = '1b35bcb94e9a686dff6460c8bca903aa0281c6696001067f34ec00093145b560'
default['android-sdk']['checksum']['mac_os_x']        = '593544d4ca7ab162705d0032fb0c0c88e75bd0f42412d09a1e8daa3394681dc6'
default['android-sdk']['checksum']['windows']         = '23d5686ffe489e5a1af95253b153ce9d6f933e5dbabe14c494631234697a0e08'

default['android-sdk']['download_url']['linux']     = "https://dl.google.com/android/repository/tools_r#{node['android-sdk']['version']}-linux.zip"
default['android-sdk']['download_url']['mac_os_x']  = "https://dl.google.com/android/repository/tools_r#{node['android-sdk']['version']}-macosx.zip"
default['android-sdk']['download_url']['windows']   = "https://dl.google.com/android/repository/tools_r#{node['android-sdk']['version']}-windows.zip"

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
default['android-sdk']['components']                  = %w[ platform-tools
                                                            build-tools-25.0.2
                                                            android-25
                                                            extra-android-support
                                                            extra-google-google_play_services
                                                            extra-google-m2repository
                                                            extra-android-m2repository ]

default['android-sdk']['license']['white_list']       = %w[.+]
default['android-sdk']['license']['black_list']       = []    # e.g. ['intel-.+', 'mips-.+', 'android-wear-sdk-license-.+']
default['android-sdk']['license']['default_answer']   = 'n'   # 'y' or 'n' ('yes' or 'no')

default['android-sdk']['scripts']['path']             = '/usr/local/bin'
default['android-sdk']['scripts']['owner']            = node['android-sdk']['owner']
default['android-sdk']['scripts']['group']            = node['android-sdk']['group']

default['android-sdk']['java_from_system']            = false

default['android-sdk']['maven-rescue']                = false
