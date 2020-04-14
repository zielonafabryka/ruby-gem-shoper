Gem::Specification.new do |s|
  s.name = "shoper"
  s.version = "0.0.1"
  s.authors = ["Pawel 'felixd' Wojciechowski"]
  s.homepage = "https://github.com/zielonafabryka/ruby-gem-shoper"
  s.date = %q{2020-04-14}
  s.description = %q{Shoper REST API}
  s.email = %q{felixd@wp.pl}
  s.require_paths = ["lib"]
  s.summary = %q{Shoper REST API}
  s.files = Dir["lib/   *.rb"] + Dir["bin/*"]
  s.files += Dir["[A-Z]*"] + Dir["test/**/*"]
  s.add_runtime_dependency "rest-client", ">= 2.1.0"
end
