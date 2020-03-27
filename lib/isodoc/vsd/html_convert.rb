require "isodoc"
require "isodoc/generic/html_convert"
require "isodoc/vsd/metadata"

module IsoDoc
  module Vsd
    # A {Converter} implementation that generates HTML output, and a document
    # schema encapsulation of the document for validation
    #
    class HtmlConvert < IsoDoc::Generic::HtmlConvert
      def configuration
        Metanorma::Vsd.configuration
      end

      def metadata_init(lang, script, labels)
        @meta = Metadata.new(lang, script, labels)
      end
    end
  end
end

