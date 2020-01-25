require "asciidoctor/standoc/converter"
require 'asciidoctor/acme/converter'

module Asciidoctor
  module Vsd
    # A {Converter} implementation that generates RSD output, and a document
    # schema encapsulation of the document for validation
    #
    class Converter < Asciidoctor::Acme::Converter
      register_for "vsd"

      def validate(doc)
        content_validate(doc)
        schema_validate(formattedstr_strip(doc.dup),
                        File.join(File.dirname(__FILE__), "vsd.rng"))
      end
    end
  end
end
