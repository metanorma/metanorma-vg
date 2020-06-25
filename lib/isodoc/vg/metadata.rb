require "isodoc"

module IsoDoc
  module VG
    class Metadata < IsoDoc::Generic::Metadata
      def configuration
        Metanorma::VG.configuration
      end
    end
  end
end
