lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metanorma/vsd/version"

Gem::Specification.new do |spec|
  spec.name          = "metanorma-vsd"
  spec.version       = Metanorma::Vsd::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]

  spec.summary       = "metanorma-vsd lets you write RSD in Metanorma."
  spec.description   = <<~DESCRIPTION
    metanorma-vsd lets you write VSD in Metanorma syntax.

    This gem is in active development.
  DESCRIPTION

  spec.homepage      = "https://github.com/metanorma/metanorma-vsd"
  spec.license       = "BSD-2-Clause"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
 spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.add_dependency "asciidoctor", "~> 1.5.7"
  spec.add_dependency "htmlentities", "~> 4.3.4"
  spec.add_dependency "nokogiri"
  spec.add_dependency "metanorma-iso", "~> 1.2.0"
  spec.add_dependency "metanorma"
  spec.add_dependency "isodoc", "~> 0.10.0"

  spec.add_development_dependency "bundler", "~> 2"
  spec.add_development_dependency "byebug", "~> 9.1"
  spec.add_development_dependency "equivalent-xml", "~> 0.6"
  spec.add_development_dependency "guard", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rubocop", "~> 0.50"
  spec.add_development_dependency "simplecov", "~> 0.15"
  spec.add_development_dependency "timecop", "~> 0.9"
  # spec.add_development_dependency "metanorma", "~> 0.2.6"
end
