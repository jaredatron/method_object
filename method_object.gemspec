# -*- encoding: utf-8 -*-
require File.expand_path('../lib/method_object', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jared Grippe"]
  gem.email         = ["jared@deadlyicon.com"]
  gem.description   = %q{wraps up the method object pattern into a class}
  gem.summary       = %q{wraps up the method object pattern into a class}
  gem.homepage      = "https://github.com/deadlyicon/method_object"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "method_object"
  gem.require_paths = ["lib"]
  gem.version       = MethodObject::VERSION

  gem.add_runtime_dependency "simple_struct"
end
