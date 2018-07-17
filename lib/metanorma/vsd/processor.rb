require "metanorma/rsd/processor"

module Metanorma
  module Vsd
    class Processor < Metanorma::Rsd::Processor

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

      def input_to_isodoc(file)
        Metanorma::Input::Asciidoc.new.process(file, @asciidoctor_backend)
      end

      def output(isodoc_node, outname, format, options={})
        case format
        when :html
          IsoDoc::Vsd::HtmlConvert.new(options).convert(outname, isodoc_node)
        when :doc
          IsoDoc::Vsd::WordConvert.new(options).convert(outname, isodoc_node)
        when :pdf
          IsoDoc::Vsd::PdfConvert.new(options).convert(outname, isodoc_node)
=begin
          require 'tempfile'
          outname_html = outname + ".html"
          IsoDoc::Vsd::HtmlConvert.new(options).convert(outname_html, isodoc_node)
          puts outname_html
          system "cat #{outname_html}"
          Metanorma::Output::Pdf.new.convert(outname_html, outname)
=end
        else
          super
        end
      end
    end
  end
end
