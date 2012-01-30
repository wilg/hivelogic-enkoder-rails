# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "enkoder_rails/version"

Gem::Specification.new do |s|
  s.name        = "enkoder_rails"
  s.version     = EnkoderRails::VERSION
  s.authors     = ["Dan Benjamin", "Wil Gieseler"]
  s.email       = ["supapuerco@gmail.com"]
  s.homepage    = "https://github.com/supapuerco/enkoder_rails"
  s.summary     = %q{A Rails gem to easily obfuscate email addresses.}
  s.description = %q{A Rails gem to easily obfuscate email addresses.}

  s.rubyforge_project = "enkoder-rails"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "activesupport", ">= 3.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
end
