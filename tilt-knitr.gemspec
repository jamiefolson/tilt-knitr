Gem::Specification.new do |s|
  s.name        = "tilt-knitr"
  s.version     = "0.0.2"
  s.authors     = ["Jamie F Olson"]
  s.email       = "self@jfolson.com"
  s.homepage    = "http://github.com/jamiefolson/tilt-knitr"
  s.summary     = %q{Add Knitr to Tilt}
  s.description = %q{Add Knitr to Tilt}
	
	s.add_dependency 'tilt'
	s.add_development_dependency 'minitest'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]
end
