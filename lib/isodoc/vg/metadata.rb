require "isodoc"

module IsoDoc
  module Vsd
    class Metadata < IsoDoc::Generic::Metadata
      def configuration
        Metanorma::Vsd.configuration
      end
    end
  end
end
