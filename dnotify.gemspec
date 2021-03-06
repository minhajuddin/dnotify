# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dnotify/version"

Gem::Specification.new do |s|
  s.name        = "dnotify"
  s.version     = Dnotify::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Khaja Minhajuddin"]
  s.email       = ["minhajuddin.k@gmail.com"]
  s.homepage    = "https://github.com/minhajuddin/dnotify"
  s.summary     = %q{Allows you to setup passive reminders for stuff}
  s.description = %q{Allows you to setup passive reminders using natural language}

  s.rubyforge_project = "dnotify"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency  'chronic', '~> 0.4'
  s.add_dependency  'libnotify', '~> 0.5'
end
