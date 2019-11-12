require "isodoc"

module IsoDoc
  module Vsd
    class Metadata < IsoDoc::Metadata
      def initialize(lang, script, labels)
        super
        here = File.dirname(__FILE__)
        set(:logo,
            File.expand_path(File.join(here, "html", "logo.png")))
      end

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
