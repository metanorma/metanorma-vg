require "asciidoctor" unless defined? Asciidoctor::Converter
require_relative "metanorma/vsd/version"
require_relative "asciidoctor/vsd"
require_relative "isodoc/vsd"

if defined? Metanorma
  require_relative "metanorma/vsd"
  Metanorma::Registry.instance.register(Metanorma::Vsd::Processor)
end
