require "isodoc"
require "isodoc/generic/word_convert"
require_relative "init"

module IsoDoc
  module VG
    # A {Converter} implementation that generates Word output, and a document
    # schema encapsulation of the document for validation
    class WordConvert < IsoDoc::Generic::WordConvert
      def configuration
        Metanorma::VG.configuration
      end

      include Init
    end
  end
end
