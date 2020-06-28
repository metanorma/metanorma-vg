require "isodoc"
require_relative "metadata"
require_relative "xref"

module IsoDoc
  module VG
    module Init
      def metadata_init(lang, script, labels)
        @meta = Metadata.new(lang, script, labels)
      end

      def xref_init(lang, script, klass, labels, options)
        @xrefs = Xref.new(lang, script, klass, labels, options)
      end
    end
  end
end

