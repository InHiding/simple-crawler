# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_crawler"
  spec.version       = SimpleCrawler::VERSION
  spec.authors       = ["Giuliano Melo"]
  spec.email         = ["giuliano.melo@gmail.com.br"]

  spec.summary       = %q{Simple Crawler that returns all assets from a domain}
  spec.description   = %q{It gets a starting URL and crawl all url on the same domain, no subdomain or cross domains will be checked, and returns a list of assets for each page}
  spec.homepage      = "http://github.com/inHiding"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "''"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.0"
  spec.add_development_dependency "pry-byebug", "~> 3.4"

  spec.add_dependency 'oga', "~> 2.9"
  spec.add_dependency 'httparty', "~> 0.14.0"
end
