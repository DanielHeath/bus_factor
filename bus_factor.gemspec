# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bus_factor/version'

Gem::Specification.new do |spec|
  spec.name          = 'bus_factor'
  spec.version       = BusFactor::VERSION
  spec.authors       = ['Daniel Heath']
  spec.email         = ['daniel@heath.cc']
  spec.summary       = 'Identify dependencies with few maintainers'
  spec.description   = 'Find things that are relatively likely to be abandoned unexpectedly'
  spec.homepage      = 'https://github.com/DanielHeath/bus_factor'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rest-client'
end
