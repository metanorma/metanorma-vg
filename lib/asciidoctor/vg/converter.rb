require "asciidoctor/standoc/converter"
require 'asciidoctor/generic/converter'

module Asciidoctor
  module VG
    # A {Converter} implementation that generates RSD output, and a document
    # schema encapsulation of the document for validation
    #
    class Converter < Asciidoctor::Generic::Converter
      register_for "vg"

      def configuration
        Metanorma::VG.configuration
      end

      def html_converter(node)
        IsoDoc::VG::HtmlConvert.new(html_extract_attributes(node))
      end

      def presentation_xml_converter(node)
        IsoDoc::VG::PresentationXMLConvert.new(html_extract_attributes(node))
      end

      def doc_converter(node)
        IsoDoc::VG::WordConvert.new(doc_extract_attributes(node))
      end
    end
  end
end
