Gem::Specification.new do |s|
  # Required BEGIN
  s.name = "shoper"
  s.version = "0.0.4"
  s.authors = ["Pawel 'felixd' Wojciechowski"]
  s.summary = %q{Shoper REST API}
  s.files = Dir["lib/*.rb"] + Dir["bin/*"]
  s.files += Dir["[A-Z]*"] + Dir["test/**/*"]
  # Required END
  # Recommended BEGIN
  s.licenses = ["MIT"]
  # Recommended BEGIN
  s.homepage = "https://github.com/zielonafabryka/ruby-gem-shoper"
  s.email = %q{felixd@wp.pl}
  s.date = %q{2020-04-14}
  s.description = %q{Shoper e-commerce Gem. This project aims to integrate Shoper REST API support in Ruby. More information can be found here: https://developers.shoper.pl/developers/api/getting-started}
  s.require_paths = ["lib"]

  s.add_runtime_dependency "rest-client", "~> 2.1", ">= 2.1.0"

  s.required_ruby_version = ">= 2.0.0"
end
