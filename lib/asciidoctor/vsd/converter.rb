require "asciidoctor/standoc/converter"
require 'asciidoctor/generic/converter'

module Asciidoctor
  module Vsd
    # A {Converter} implementation that generates RSD output, and a document
    # schema encapsulation of the document for validation
    #
    class Converter < Asciidoctor::Generic::Converter
      register_for "vsd"

      def configuration
        Metanorma::Vsd.configuration
      end

      def html_converter(node)
        IsoDoc::Vsd::HtmlConvert.new(html_extract_attributes(node))
      end

      def presentation_xml_converter(node)
        IsoDoc::Vsd::PresentationXMLConvert.new(html_extract_attributes(node))
      end

      def doc_converter(node)
        IsoDoc::Vsd::WordConvert.new(doc_extract_attributes(node))
      end
    end
  end
end
