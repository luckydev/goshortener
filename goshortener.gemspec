Gem::Specification.new do |spec|
  spec.name = %q{goshortener}
  spec.version = "0.1"
  spec.summary = %q{uses google url shortener service to shorten/expand urls}
  spec.description = %q{uses google url shortener service to shorten/expand urls}
  spec.homepage = "http://github.com/luckydev/goshortener" 
  spec.authors = ["lakshmanan"]
  spec.email = "lucky.developer@gmail.com"
  spec.require_paths = ["lib"]

  spec.add_dependency('json')
  spec.add_dependency('rest-client')
end

