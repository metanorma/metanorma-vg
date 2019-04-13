require "isodoc"

module IsoDoc
  module Vsd
    class Metadata < IsoDoc::Metadata

      def security(isoxml, _out)
        keywords = []
        isoxml.xpath(ns("//bibdata/keyword")).each do |kw|
          keywords << kw.text
        end
        set(:keywords, keywords)
      end

    end
  end
end
