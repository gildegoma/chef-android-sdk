Fix emulator errors (missing library)

instead of 

$ echo no | android create avd --force -n test -t $ANDROID_TARGET --abi $ANDROID_ABI
Android 2.2 is a basic Android platform.
Do you wish to create a custom hardware profile [no]Created AVD 'test' based on Android 2.2, ARM (armeabi) processor,
with the following hardware config:
hw.lcd.density=240
vm.heapSize=24
before_install.9
$ emulator -avd test -no-skin -no-audio -no-window &
Failed to Initialize backend EGL display
emulator: WARNING: Could not initialize OpenglES emulation, using software renderer.

I observe:

vagrant@temp-ubuntu-1204:~/tests/android-maven-example$ android create avd --force -n test -t android-17 --abi armeabi-v7a
Failed to load lib64EGL_translator.so
error libGL.so.1: cannot open shared object file: No such file or directory
Failed to open lib64EGL_translator.so
Failed to init_egl_dispatch
emulator: ERROR: OpenGLES initialization failed!
emulator: ERROR: OpenGLES emulation library could not be initialized!
emulator: WARNING: Could not initialize OpenglES emulation, using software renderer.
Android 4.2.2 is a basic Android platform.



instead of
$ ./wait_for_emulator
stopped
Done

I observe:

vagrant@temp-ubuntu-1204:~/tests/android-maven-example$ ./wait_for_emulator
Failed to load lib64EGL_translator.so
error libGL.so.1: cannot open shared object file: No such file or directory
Failed to open lib64EGL_translator.so
Failed to init_egl_dispatch
emulator: ERROR: OpenGLES initialization failed!
emulator: ERROR: OpenGLES emulation library could not be initialized!
emulator: WARNING: Could not initialize OpenglES emulation, using software renderer.
error: device offline
* daemon not running. starting it now on port 5037 *
* daemon started successfully *
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
error: device offline
running
running
running
running
running
running
running
running
running
running
running
running
running
running

make the setup works when files are owned/installed by root.root (or other default values)

Fix Gemfile conflict, see https://github.com/miketheman/knife-community/issues/15#issuecomment-22252568

publish to community site

Remove this TODO list and create equivalent GitHub issues !!!

Remove all #TODO comments in source code and create equivalent GitHub issues !!!

Improve test-kitche suites with inspiration from examples like:
 * https://github.com/opscode-cookbooks/maven/blob/master/.kitchen.yml

Add more 64-bit linuxes

Support Mac, Windows

Better handle Android License agreements prompt. See https://github.com/travis-ci/travis-cookbooks/pull/153#issuecomment-22078355

Add chefspec examples

Try to upgrade Berkshelf dependency


