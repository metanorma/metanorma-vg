require 'metanorma'
require 'metanorma/vg'
require "isodoc/vg"

require 'asciidoctor' unless defined? Asciidoctor::Converter
require 'asciidoctor/vg'

if defined? Metanorma
  require_relative "metanorma/vg"
  Metanorma::Registry.instance.register(Metanorma::VG::Processor)
end
