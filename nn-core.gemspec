# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nn-core/version"

Gem::Specification.new do |s|
  s.name        = "nn-core"
  s.version     = NNCore::VERSION
  s.authors     = ["Chuck Remes"]
  s.email       = ["git@chuckremes.com"]
  s.homepage    = "http://github.com/chuckremes/nn-core"
  s.summary     = %q{Wraps the nanomsg networking library using Ruby FFI (foreign function interface).}
  s.description = %q{Wraps the nanomsg networking library using the ruby FFI (foreign
function interface). It only exposes the native C API to Ruby. Other gems should use this gem
to build an API using Ruby idioms.}

  s.rubyforge_project = "nn-core"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "ffi"
  s.add_development_dependency "rspec", ["~> 2.6"]
  s.add_development_dependency "rake"
end
