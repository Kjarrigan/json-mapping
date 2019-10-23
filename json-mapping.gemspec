# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json/mapping/version'

Gem::Specification.new do |spec|
  spec.name          = 'json-mapping'
  spec.version       = JSON::Mapping::VERSION
  spec.authors       = ['Kjarrigan']
  spec.email         = ['github@kjarrigan.de']

  spec.summary       = 'Define ruby objects to directly parse from JSON.'
  spec.description   = "Inspired by Crystal's JSON.mapping."
  spec.homepage      = 'https://github.com/kjarrigan/json-mapping'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
