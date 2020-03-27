require "metanorma/processor"

module Metanorma
  module Vsd
    class Processor < Metanorma::Processor
      def initialize
        @short = :vsd
        @input_format = :asciidoc
        @asciidoctor_backend = :vsd
      end

      def output_formats
        super.merge(
          html: "html",
          doc: "doc",
          pdf: "pdf"
        )
      end

      def version
        "Metanorma::Vsd #{Metanorma::Vsd::VERSION}"
      end

      def input_to_isodoc(file, filename)
        Metanorma::Input::Asciidoc.new.process(file, filename, @asciidoctor_backend)
      end

      def output(isodoc_node, outname, format, options={})
        case format
        when :html
          IsoDoc::Vsd::HtmlConvert.new(options).convert(outname, isodoc_node)
        when :doc
          IsoDoc::Vsd::WordConvert.new(options).convert(outname, isodoc_node)
        when :pdf
          IsoDoc::Generic::PdfConvert.new(options).convert(outname, isodoc_node)
        else
          super
        end
      end
    end
  end
end
