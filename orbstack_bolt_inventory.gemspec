# frozen_string_literal: true

require_relative 'lib/orbstack_bolt_inventory/version'

Gem::Specification.new do |spec|
  spec.name          = 'orbstack_bolt_inventory'
  spec.version       = OrbstackBoltInventory::VERSION
  spec.authors       = ['Gavin Didrichsen']
  spec.email         = ['gavin.didrichsen@gmail.com']

  spec.summary       = 'Generate Bolt inventory for Orbstack VMs'
  spec.description   = 'A Ruby gem to generate Puppet Bolt inventory files for Orbstack virtual machines'
  spec.homepage      = 'https://github.com/gavindidrichsen/orbstack_bolt_inventory'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob(%w[
                          lib/**/*
                          exe/*
                          *.gemspec
                          LICENSE*
                          CHANGELOG*
                          README*
                        ])
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Runtime dependencies
  spec.add_dependency 'json', '>= 2.1.0', '< 3.0' # More flexible version range
  spec.add_dependency 'yaml', '~> 0.2'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 2.4'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.21'
  spec.add_development_dependency "rubocop-rake", "~> 0.6.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.25.0"
end
