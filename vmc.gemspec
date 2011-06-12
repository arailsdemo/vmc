# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vmc/version"

Gem::Specification.new do |s|
  s.name        = "vmc"
  s.version     = VMC::VERSION
  s.authors     = ["aRailsDemo"]
  s.email       = ["arailsdemo@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "vmc"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 2.6'
  s.add_development_dependency 'webmock', '~> 1.6'
  s.add_development_dependency 'guard-rspec', '~> 0.4'

  s.add_runtime_dependency 'yajl-ruby', '~> 0.8'
  s.add_runtime_dependency 'faraday_middleware', '~> 0.6'
  s.add_runtime_dependency 'rash', '~> 0.3'
  s.add_runtime_dependency 'multi_json', '~> 1.0'
end
