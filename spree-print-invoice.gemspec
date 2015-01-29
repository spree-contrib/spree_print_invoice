# -*- encoding: utf-8 -*-
version = File.read(File.expand_path("../SPREE_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_print_invoice'
  s.version     = '2.3.4'
  s.summary     = 'Print invoices from a spree order'
  s.homepage    = 'https://github.com/spree/spree_print_invoice'

  s.required_ruby_version = '>= 1.8.7'

  s.files        = Dir['README.md', 'lib/**/*', 'app/**/*', 'config/*']
  s.require_path = 'lib'
  s.requirements << 'none'
  s.authors      = 'Spree Community'

  s.add_dependency('prawn', '1.0.0')

  s.add_dependency 'spree_core', '~> 2.3.0' #version

  s.add_development_dependency 'rspec-rails', '~> 2.14.0'
end
