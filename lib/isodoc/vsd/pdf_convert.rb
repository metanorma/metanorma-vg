require "isodoc"
require "isodoc/vsd/metadata"

module IsoDoc
  module Vsd
    # A {Converter} implementation that generates PDF HTML output, and a
    # document schema encapsulation of the document for validation
    class PdfConvert < IsoDoc::Acme::PdfConvert
      def configuration
        Metanorma::Vsd.configuration
      end

      def metadata_init(lang, script, labels)
        @meta = Metadata.new(lang, script, labels)
      end
    end
  end
end

