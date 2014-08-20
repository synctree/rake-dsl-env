# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rake/dsl/env/version'

Gem::Specification.new do |spec|
  spec.name          = 'rake-dsl-env'
  spec.version       = Rake::DSL::Env::VERSION
  spec.authors       = ['Mike Dillon']
  spec.email         = ['mike.dillon@synctree.com']
  spec.summary       = %q{Rake extension providing environment functionality}
  spec.description   = %q{Rake extension providing environment functionality a la Capistrano}
  spec.homepage      = 'https://github.com/md5/rake-dsl-env/wiki'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split(0.chr)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rake', '>= 10.0.0'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'mocha'
end
