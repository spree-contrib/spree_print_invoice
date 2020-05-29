# coding: utf-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_print_invoice/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_print_invoice'
  s.version     = SpreePrintInvoice.version
  s.summary     = 'Print invoices and slips from Spree Commerce'
  s.description = s.summary
  s.required_ruby_version = '>= 2.1.0'

  s.authors      = ['Spree Commerce', 'Tobias Bohwalli', 'Martin Meyerhoff']
  s.email        = 'gems@spreecommerce.com'
  s.homepage     = 'https://github.com/spree-contrib/spree_print_invoice'
  s.license      = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_runtime_dependency 'prawn-rails', '~> 1.3'
  s.add_runtime_dependency 'spree_core', '>= 3.1.0', '< 5.0'
  s.add_runtime_dependency 'spree_extension'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'pdf-inspector'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'pg'
  s.add_development_dependency 'mysql2'
  s.add_development_dependency 'appraisal'
end
