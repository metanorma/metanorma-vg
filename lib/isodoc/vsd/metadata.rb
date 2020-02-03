require "isodoc"

module IsoDoc
  module Vsd
    class Metadata < IsoDoc::Acme::Metadata
      def configuration
        Metanorma::Vsd.configuration
      end
    end
  end
end
