# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-append-kubernetes-annotations-to-tag"
  gem.version       = ENV["VERSION"]
  gem.authors       = ["Redbubble Delivery Engineering Team"]
  gem.email         = ["delivery-engineers@redbubble.com"]
  gem.description   = %q{Plugin to append Kubernetes annotations to Fluentd tags}
  gem.summary       = %q{Filter plugin to append certain Kubernetes annotations to the Fluentd tag}
  gem.homepage      = "https://github.com/redbubble/fluent-plugin-append_kubernetes_annotations_to_tag"
  gem.license       = "MIT"

  gem.files = Dir['lib/**/*'] + %w(Gemfile README.md fluent-plugin-append-kubernetes-annotations-to-tag.gemspec)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 2.5.0'

  gem.add_runtime_dependency "fluentd", '~> 1.3.3', '>= 1.3.3'

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rspec", "~> 3.0"
end
