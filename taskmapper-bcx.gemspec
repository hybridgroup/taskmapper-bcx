# -*- encoding: utf-8 -*-
require File.expand_path '../lib/provider/version', __FILE__

Gem::Specification.new do |spec|
  spec.name          = "taskmapper-bcx"
  spec.version       = TaskMapper::Provider::Bcx::VERSION
  spec.authors       = ["www.hybridgroup.com"]
  spec.email         = ["info@hybridgroup.com"]
  spec.description   = %q{A TaskMapper provider for interfacing with Basecamp Next.}
  spec.summary       = %q{A TaskMapper provider for interfacing with Basecamp Next.}
  spec.homepage      = "http://ticketrb.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.11.0"
  spec.add_dependency "taskmapper", "~> 1.0"
  spec.add_dependency "json", "~> 1.8.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
  spec.add_development_dependency "fakeweb", "~> 1.3.0"
end
