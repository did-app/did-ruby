Gem::Specification.new do |s|
  s.name        = 'kno'
  s.version     = '0.1.1'
  s.summary     = "The simplest way to add passwordless authentication to your Rails/Rack application."
  s.authors     = ["Peter Saxton"]
  s.email       = 'team@trykno.com'
  s.files       = Dir["lib/**/*", "LICENSE", "README.md"]
  s.homepage    = 'https://trykno.com'
  s.license       = 'Apache-2.0'

  s.add_dependency "faraday", "~> 1.0"
end
