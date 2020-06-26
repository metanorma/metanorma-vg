require "isodoc"
require "isodoc/generic/word_convert"
require "isodoc/vg/metadata"

module IsoDoc
  module VG
    # A {Converter} implementation that generates Word output, and a document
    # schema encapsulation of the document for validation
    class WordConvert < IsoDoc::Generic::WordConvert
      def configuration
        Metanorma::VG.configuration
      end

      def metadata_init(lang, script, labels)
        @meta = Metadata.new(lang, script, labels)
      end
    end
  end
end
