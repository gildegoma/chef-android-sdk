name 'android-sdk'
maintainer 'Gilles Cornu'
maintainer_email 'foss@gilles.cornu.name'
license 'Apache 2.0'
description 'Installs Google Android SDK'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.com/gildegoma/chef-android-sdk/issues'
source_url 'https://github.com/gildegoma/chef-android-sdk'
version '0.2.0'

depends 'java'
depends 'ark', '>= 1.1.0'
depends 'homebrew', '>= 2.1.0'
depends 'bash', '~> 0.1.2'
depends 'chef-sugar', '>= 3.3.0'

# TODO: maybe put maven into depends section
recommends 'maven' # Maven 3.1.1+ is required by android-sdk::maven-rescue recipe

supports 'ubuntu', '>= 12.04'
supports 'centos', '>= 6.6'
supports 'mac_os_x'

# Support for more platforms is on the road (e.g. Debian, CentOS,...).
# Please watch or help on https://github.com/gildegoma/chef-android-sdk/issues/5

recipe 'android-sdk::default', 'Install and update Google Android SDK'
recipe 'android-sdk::maven_rescue', 'Install missing dependencies with Maven '\
  'Android SDK Deployer'
