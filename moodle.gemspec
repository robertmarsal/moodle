Gem::Specification.new do |spec|
  spec.name        = 'moodle'
  spec.version     = '0.1.1'
  spec.date        = Date.today.to_s
  spec.summary     = "Moodle web services from ruby"
  spec.description = "Interact with Moodle from ruby"
  spec.authors     = ["Robert Boloc"]
  spec.email       = 'robertboloc@gmail.com'
  spec.files       = `git ls-files`.split("\n")
  spec.homepage    =
    'http://robertboloc.github.com/moodle'
  spec.license     = 'MIT'
  
  spec.add_runtime_dependency 'rest-client', '~> 1.8'
  spec.add_runtime_dependency 'hashie', '~> 3.4'
  spec.add_runtime_dependency 'json', '~> 1.8'

  spec.add_development_dependency 'rake', '~> 11.1'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'mocha', '~> 1.1'
end
