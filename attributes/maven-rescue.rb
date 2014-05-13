
default['android-sdk']['maven-android-sdk-deployer']['name']         = "maven-android-sdk-deployer"
default['android-sdk']['maven-android-sdk-deployer']['version']      = "9c3a8d91c920957e285b9857ef782faead364cb9"
default['android-sdk']['maven-android-sdk-deployer']['checksum']     = "95d496c89d688dd3bf032bdda058632fa27b47582d95e9fe96f2be202f687f8a"
default['android-sdk']['maven-android-sdk-deployer']['download_url'] = "https://github.com/mosabua/maven-android-sdk-deployer/archive/#{node['android-sdk']['maven-android-sdk-deployer']['version']}.tar.gz"

default['android-sdk']['maven-local-repository']                     = "$HOME/.m2/repository"
																	   # FIXME this default is crappy, as $HOME is not well handled by the recipe.
																	   # TODO explain/verify why I don't want to be depending on
																	   # Maven cookbook attributes (e.g. use node['maven']['mavenrc']['opts'])