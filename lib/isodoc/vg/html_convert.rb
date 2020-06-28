require "isodoc"
require "isodoc/generic/html_convert"
require_relative "init"

module IsoDoc
  module VG
    # A {Converter} implementation that generates HTML output, and a document
    # schema encapsulation of the document for validation
    #
    class HtmlConvert < IsoDoc::Generic::HtmlConvert
      def configuration
        Metanorma::VG.configuration
      end

      include Init
    end
  end
end

