require "isodoc"
require "isodoc/generic/html_convert"
require "isodoc/vg/metadata"

module IsoDoc
  module VG
    # A {Converter} implementation that generates HTML output, and a document
    # schema encapsulation of the document for validation
    #
    class HtmlConvert < IsoDoc::Generic::HtmlConvert
      def configuration
        Metanorma::VG.configuration
      end

      def metadata_init(lang, script, labels)
        @meta = Metadata.new(lang, script, labels)
      end
    end
  end
end

