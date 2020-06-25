require "metanorma/processor"

module Metanorma
  module VG
    class Processor < Metanorma::Generic::Processor
      def configuration
        Metanorma::VG.configuration
      end

      def output_formats
        super.merge(
          html: "html",
          doc: "doc"
        ).tap { |hs| hs.delete(:pdf) }
      end

      def version
        "Metanorma::VG #{Metanorma::VG::VERSION}"
      end

      def input_to_isodoc(file, filename)
        Metanorma::Input::Asciidoc.new.process(file, filename, @asciidoctor_backend)
      end

      def output(isodoc_node, outname, format, options={})
        case format
        when :html
          IsoDoc::VG::HtmlConvert.new(options).convert(outname, isodoc_node)
        when :doc
          IsoDoc::VG::WordConvert.new(options).convert(outname, isodoc_node)
        else
          super
        end
      end
    end
  end
end
