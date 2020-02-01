require "isodoc"
require "isodoc/acme/word_convert"
require "isodoc/vsd/metadata"

module IsoDoc
  module Vsd
    # A {Converter} implementation that generates Word output, and a document
    # schema encapsulation of the document for validation
    class WordConvert < IsoDoc::Acme::WordConvert
      def configuration
        Metanorma::Vsd.configuration
      end

      def metadata_init(lang, script, labels)
        @meta = Metadata.new(lang, script, labels)
      end
    end
  end
end
