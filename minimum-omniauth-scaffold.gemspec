# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minimum/omniauth/scaffold/version'

Gem::Specification.new do |spec|
  spec.name          = "minimum-omniauth-scaffold"
  spec.version       = Minimum::Omniauth::Scaffold::VERSION
  spec.authors       = ["shu0115"]
  spec.email         = ["s.matsumoto0115@gmail.com"]
  spec.description   = %q{Scaffold for OmniAuth}
  spec.summary       = %q{Scaffold for OmniAuth}
  spec.homepage      = "https://github.com/shu0115/minimum-omniauth-scaffold"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  gem.add_dependency 'rails_config'
  gem.add_dependency 'omniauth-twitter'
  gem.add_dependency 'omniauth-facebook'
  gem.add_dependency 'omniauth-github'
end

