# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'spree_print_invoice/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_print_invoice'
  s.version     = Spree::PrintInvoice.version
  s.summary     = 'Print invoices from a spree order'
  s.description = s.summary
  s.required_ruby_version = '>= 1.9.3'

  s.authors      = ['Roman Le Négrate', 'Torsten Rüger']
  s.email        = 'roman.lenegrate@gmail.com'
  s.homepage     = 'https://github.com/spree/spree_print_invoice'
  s.license      = %q{BSD-3}

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'prawn', '~> 1.0.0'
  s.add_dependency 'spree_core', '~> 2.3.0.beta'

  s.add_development_dependency 'capybara', '~> 2.2.1'
  s.add_development_dependency 'selenium-webdriver', '~> 2.40'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails', '~> 2.14'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3', '~> 1.3.9'
  s.add_development_dependency 'database_cleaner', '~> 1.2.0'
  s.add_development_dependency 'coffee-rails', '~> 4.0.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'pdf-inspector', '~> 1.1.0'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry-rails'
end