require 'bundler'
require "rubygems"
require "bundler/setup"
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
require 'spree/testing_support/common_rake'

RSpec::Core::RakeTask.new

task default: :spec

desc 'Generates a dummy app for testing'
task :test_app do
  ENV['LIB_NAME'] = 'spree_print_invoice'
  Rake::Task['common:test_app'].invoke
end
