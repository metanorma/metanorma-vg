require "asciidoctor/standoc/converter"
require 'asciidoctor/acme/converter'

module Asciidoctor
  module Vsd
    # A {Converter} implementation that generates RSD output, and a document
    # schema encapsulation of the document for validation
    #
    class Converter < Asciidoctor::Acme::Converter
      register_for "vsd"
    end
  end
end
