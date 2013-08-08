emulator: WARNING: Could not initialize OpenglES emulation, using software renderer.
maybe no need to fix (same warning on https://travis-ci.org/embarkmobile/android-maven-example)

---

Part 1 - Be able to build https://travis-ci.org/embarkmobile/android-maven-example on vagrant box


What is "very" interesting, is that the error is the same as random (occured only once) found here
https://travis-ci.org/embarkmobile/android-maven-example/jobs/9867824

--------

-Dandroid.sdk.path=$ANDROID_HOME

Part 2 - Be able to build https://travis-ci.org/embarkmobile/android-maven-example on vagrant box

vagrant@temp-ubuntu-1204:~/tests/android-maven-example$ mvn install -Pintegration-tests -Dandroid.device=test
[INFO] Scanning for projects...
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Build Order:
[INFO] 
[INFO] androidexample
[INFO] androidexample-lib
[INFO] androidexample-app
[INFO] androidexample-tests
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building androidexample 1.0.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- maven-install-plugin:2.3:install (default-install) @ androidexample ---
[INFO] Installing /home/vagrant/tests/android-maven-example/pom.xml to /home/vagrant/.m2/repository/com/embarkmobile/androidexample/androidexample/1.0.0-SNAPSHOT/androidexample-1.0.0-SNAPSHOT.pom
[INFO]                                                                         
[INFO] ------------------------------------------------------------------------
[INFO] Building androidexample-lib 1.0.0-SNAPSHOT
[INFO] ------------------------------------------------------------------------
[INFO] 
[INFO] --- android-maven-plugin:3.6.0:generate-sources (default-generate-sources) @ androidexample-lib ---
[INFO] ANDROID-904-002: Found aidl files: Count = 0
[INFO] ANDROID-904-002: Found aidl files: Count = 0
[INFO] Manifest merging disabled. Using project manifest only
[ERROR] Error when generating sources.
org.apache.maven.plugin.MojoExecutionException: No Android SDK path could be found. You may configure it in the plugin configuration section in the pom file using <sdk><path>...</path></sdk> or <properties><android.sdk.path>...</android.sdk.path></properties> or on command-line using -Dandroid.sdk.path=... or by setting environment variable ANDROID_HOME
	at com.jayway.maven.plugins.android.AbstractAndroidMojo.getAndroidHomeOrThrow(AbstractAndroidMojo.java:1163)
	at com.jayway.maven.plugins.android.AbstractAndroidMojo.getAndroidSdk(AbstractAndroidMojo.java:1116)
	at com.jayway.maven.plugins.android.phase01generatesources.GenerateSourcesMojo.generateR(GenerateSourcesMojo.java:461)
	at com.jayway.maven.plugins.android.phase01generatesources.GenerateSourcesMojo.execute(GenerateSourcesMojo.java:195)
	at org.apache.maven.plugin.DefaultBuildPluginManager.executeMojo(DefaultBuildPluginManager.java:101)
	at org.apache.maven.lifecycle.internal.MojoExecutor.execute(MojoExecutor.java:209)
	at org.apache.maven.lifecycle.internal.MojoExecutor.execute(MojoExecutor.java:153)
	at org.apache.maven.lifecycle.internal.MojoExecutor.execute(MojoExecutor.java:145)
	at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject(LifecycleModuleBuilder.java:84)
	at org.apache.maven.lifecycle.internal.LifecycleModuleBuilder.buildProject(LifecycleModuleBuilder.java:59)
	at org.apache.maven.lifecycle.internal.LifecycleStarter.singleThreadedBuild(LifecycleStarter.java:183)
	at org.apache.maven.lifecycle.internal.LifecycleStarter.execute(LifecycleStarter.java:161)
	at org.apache.maven.DefaultMaven.doExecute(DefaultMaven.java:320)
	at org.apache.maven.DefaultMaven.execute(DefaultMaven.java:156)
	at org.apache.maven.cli.MavenCli.execute(MavenCli.java:537)
	at org.apache.maven.cli.MavenCli.doMain(MavenCli.java:196)
	at org.apache.maven.cli.MavenCli.main(MavenCli.java:141)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:57)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:43)
	at java.lang.reflect.Method.invoke(Method.java:616)
	at org.codehaus.plexus.classworlds.launcher.Launcher.launchEnhanced(Launcher.java:290)
	at org.codehaus.plexus.classworlds.launcher.Launcher.launch(Launcher.java:230)
	at org.codehaus.plexus.classworlds.launcher.Launcher.mainWithExitCode(Launcher.java:409)
	at org.codehaus.plexus.classworlds.launcher.Launcher.main(Launcher.java:352)
[INFO] ------------------------------------------------------------------------
[INFO] Reactor Summary:
[INFO] 
[INFO] androidexample .................................... SUCCESS [0.912s]
[INFO] androidexample-lib ................................ FAILURE [2.856s]
[INFO] androidexample-app ................................ SKIPPED
[INFO] androidexample-tests .............................. SKIPPED
[INFO] ------------------------------------------------------------------------
[INFO] BUILD FAILURE
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 14.296s
[INFO] Finished at: Wed Aug 07 15:34:33 UTC 2013
[INFO] Final Memory: 9M/27M
[INFO] ------------------------------------------------------------------------
[ERROR] Failed to execute goal com.jayway.maven.plugins.android.generation2:android-maven-plugin:3.6.0:generate-sources (default-generate-sources) on project androidexample-lib: No Android SDK path could be found. You may configure it in the plugin configuration section in the pom file using <sdk><path>...</path></sdk> or <properties><android.sdk.path>...</android.sdk.path></properties> or on command-line using -Dandroid.sdk.path=... or by setting environment variable ANDROID_HOME -> [Help 1]
[ERROR] 
[ERROR] To see the full stack trace of the errors, re-run Maven with the -e switch.
[ERROR] Re-run Maven using the -X switch to enable full debug logging.
[ERROR] 
[ERROR] For more information about the errors and possible solutions, please read the following articles:
[ERROR] [Help 1] http://cwiki.apache.org/confluence/display/MAVEN/MojoExecutionException
[ERROR] 
[ERROR] After correcting the problems, you can resume the build with the command
[ERROR]   mvn <goals> -rf :androidexample-lib


--------

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

Try to take advantage of `append_env_path` ark option

Finalize travis-solo and validate this cookbook with android-maven-example in a TK suite
