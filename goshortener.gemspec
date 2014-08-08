Gem::Specification.new do |spec|
  spec.name = %q{goshortener}
  spec.version = "1.2.3"
  spec.summary = %q{GoShortener uses Google URL shortener service to shorten/expand urls.}
  spec.description = %q{GoShortener uses Google URL shortener service to shorten/expand urls.}
  spec.homepage = "http://github.com/luckydev/goshortener"
  spec.authors = ["Anand"]
  spec.email = "lucky.developer@gmail.com"

  spec.files = Dir["README.rdoc", "MIT-LICENSE", "lib/*.rb"]
  spec.require_paths = ["lib"]

  spec.add_dependency('json')
  spec.add_dependency('rest-client')
end
