lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'petstore_client/version'

Gem::Specification.new do |spec|
  spec.name = 'petstore_client'
  spec.version = PetstoreClient::VERSION
  spec.authors = ['Vladislav']
  spec.email = ['nafikov.v.r@ya.ru']

  spec.summary = 'Client to petstore.swagger.io API'
  spec.homepage = 'https://github.com/vnafikov/petstore_client'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.metadata['allowed_push_host'] = ''
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activeresource', '~> 5.0'
  spec.add_dependency 'rails', '~> 5.2'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'combustion', '~> 0.9'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.7'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'
end
