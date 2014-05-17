# TODO: decide which way we depend on maven (weak dependency, conditional include_recipe or always include_recipe?)
# include_recipe "maven"

#
# Install Maven Android SDK Deployer from tarball package, but it also could make sense
# to clone the git repository (especially when provisioning a developer box)
#
ark node['android-sdk']['maven-android-sdk-deployer']['name'] do
  url         		node['android-sdk']['maven-android-sdk-deployer']['download_url']
  # TODO: checksum check here is maybe overkill optimization without real safety added value
  checksum    		node['android-sdk']['maven-android-sdk-deployer']['checksum']
  version     		node['android-sdk']['maven-android-sdk-deployer']['version']
  prefix_root 		node['android-sdk']['setup_root']
  prefix_home 		node['android-sdk']['setup_root']
  append_env_path false
  owner       		node['android-sdk']['owner']
  group       		node['android-sdk']['group']
end

maven_android_sdk_deployer_root = node['android-sdk']['setup_root'].to_s.empty? ? node['ark']['prefix_home'] : node['android-sdk']['setup_root']
maven_android_sdk_deployer_home = File.join(maven_android_sdk_deployer_root, node['android-sdk']['maven-android-sdk-deployer']['name'])

#
# Deploy Android SDK jar files to a Maven local repository
# TODO: fix a few target name mismatches in the extra folder (fe. admob, google-play-services-for-froyo, ...)
#
# Loop over node['android-sdk']['components'],
# convert android component name to the target names used in maven-android-sdk-deployer
# and generate `mvn -pl component1,component2,... install` command.
#

components = Array.new

node['android-sdk']['components'].each do |sdk_component|
  # android APIs
  if sdk_component =~ /android-[0-9]+/
    components << sdk_component.sub("android", "platforms/android")
  # android and GDK addon APIs
  else if sdk_component =~ /addon-google_(apis|gdk)-google-[0-9]+/
      components << sdk_component.sub("addon-google_", "add-ons/google-").sub("-google","")
    # m2 repositories
    else if sdk_component =~ /extra-(google|android)-m2repository/
        components << sdk_component.sub("extra-", "repositories/")
      # extras
      else if sdk_component =~ /extra-google-+/
          components << sdk_component.sub("extra-google-", "extras/").gsub("_","-")
        end
      end
    end
  end
end

execute 'Execute maven-android-sdk-deployer' do
  command       "mvn clean install -pl #{components.join(",")} -Dmaven.repo.local=#{node['android-sdk']['maven-local-repository']} --fail-never -B"
  user          node['android-sdk']['owner']
  group         node['android-sdk']['group']
  cwd           maven_android_sdk_deployer_home

  # FIXME: setting HOME might be required (if $HOME used in node['android-sdk']['maven-local-repository'],
  #        or if -Dmaven.repo.local is unset (default to ~/.m2/repository)
  # environment   ({ 'HOME' => '/home/vagrant' })

  # Note: There is no idempotent guard for now. Pending on https://github.com/gildegoma/chef-android-sdk/issues/12.
end

