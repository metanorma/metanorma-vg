require "asciidoctor/standoc/converter"
require 'asciidoctor/acme/converter'

module Asciidoctor
  module Vsd
    # A {Converter} implementation that generates RSD output, and a document
    # schema encapsulation of the document for validation
    #
    class Converter < Asciidoctor::Acme::Converter
      register_for "vsd"

      def configuration
        Metanorma::Vsd.configuration
      end

      def html_converter(node)
        IsoDoc::Vsd::HtmlConvert.new(html_extract_attributes(node))
      end

      def pdf_converter(node)
        IsoDoc::Vsd::PdfConvert.new(html_extract_attributes(node))
      end

      def word_converter(node)
        IsoDoc::Vsd::WordConvert.new(doc_extract_attributes(node))
      end
    end
  end
end
