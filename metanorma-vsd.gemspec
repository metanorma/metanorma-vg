lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "metanorma/vg/version"

Gem::Specification.new do |spec|
  spec.name          = "metanorma-vg"
  spec.version       = Metanorma::VG::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]

  spec.summary       = "metanorma-vg lets you write Vita Green standards in Metanorma."
  spec.description   = <<~DESCRIPTION
    metanorma-vg lets you write Vita Green standards in Metanorma syntax.

    This gem is in active development.

    Formerly known as metanorma-vsd.
  DESCRIPTION

  spec.homepage      = "https://github.com/metanorma/metanorma-vg"
  spec.license       = "BSD-2-Clause"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
 spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.add_dependency "metanorma-generic", "~> 1.6.0"
  spec.add_dependency "isodoc", "~> 1.2.0"

  spec.add_development_dependency "byebug", "~> 9.1"
  spec.add_development_dependency "sassc", "2.4.0"
  spec.add_development_dependency "equivalent-xml", "~> 0.6"
  spec.add_development_dependency "guard", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "rubocop", "~> 0.50"
  spec.add_development_dependency "simplecov", "~> 0.15"
  spec.add_development_dependency "timecop", "~> 0.9"
end
