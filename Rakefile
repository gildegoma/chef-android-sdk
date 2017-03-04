#!/usr/bin/env rake

require 'foodcritic'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

# TODO: add chefspec
task default: [:rubocop, :foodcritic, :knife, :serverspec]

desc 'Lint Ruby code'
RuboCop::RakeTask.new

FoodCritic::Rake::LintTask.new do |t|
  t.options = { fail_tags: ['any'], tags: ['~FC041', '~FC053'] }
end

desc 'Run serverspec test'
task :serverspec do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'test/integration/default/serverspec/*_spec.rb'
  end
  Rake::Task['spec'].execute
end

desc 'Run knife cookbook test'
task :knife do
  Rake::Task[:prepare_sandbox].execute

  sh "bundle exec knife cookbook test #{cookbook_name} -c #{sandbox_root}/knife.rb"
end

task :prepare_sandbox do
  files = %w(*.md *.rb attributes definitions files providers recipes resources templates)

  rm_rf sandbox_root
  mkdir_p sandbox_path
  mkdir_p File.join(sandbox_root, 'cache')

  cp_r Dir.glob("{#{files.join(',')}}"), sandbox_path

  File.open(knife_rb, 'w') do |fp|
    fp.write("cookbook_path ['#{sandbox_root}/cookbooks/']\n")
    fp.write("cache_type    'BasicFile'\n")
    fp.write("cache_options :path => '#{sandbox_root}/cache'\n")
  end

  # Add fake dependant cookbooks (put only the stuff chefspec will verify)
  # TODO: DRY: read 'depends' from metadata.rb...
  cookbook_deps = %w(java ark)
  cookbook_deps.each do |dep|
    mkdir_p File.join(sandbox_cookbooks, dep, 'recipes')
    touch File.join(sandbox_cookbooks, dep, %w(recipes default.rb))
    touch File.join(sandbox_cookbooks, dep, 'README.md')
  end
end

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
end

private

def cookbook_name
  'android-sdk'
end

def sandbox_root
  File.join(File.dirname(__FILE__), %w(tmp))
end

def sandbox_cookbooks
  File.join(sandbox_root, 'cookbooks')
end

def sandbox_path
  File.join(sandbox_cookbooks, cookbook_name)
end

def knife_rb
  File.join(sandbox_root, 'knife.rb')
end
