require "isodoc/word_convert"
require_relative "metadata"

module IsoDoc
  module Vsd
    # A {Converter} implementation that generates Word output, and a document
    # schema encapsulation of the document for validation

    class WordConvert < IsoDoc::WordConvert
      def initialize(options)
        @libdir ||= File.dirname(__FILE__)
        super
      end

      def default_fonts(options)
        {
            bodyfont: (options[:script] == "Hans" ? '"SimSun",serif' : '"Arial",sans-serif'),
            headerfont: (options[:script] == "Hans" ? '"SimHei",sans-serif' : '"Arial",sans-serif'),
            monospacefont: '"Courier New",monospace'
        }
      end

      def default_file_locations(options)
        {
            wordstylesheet: html_doc_path("wordstyle.scss"),
            standardstylesheet: html_doc_path("vsd.scss"),
            header: html_doc_path("header.html"),
            wordcoverpage: html_doc_path("word_vsd_titlepage.html"),
            wordintropage: html_doc_path("word_vsd_intro.html"),
            ulstyle: "l3",
            olstyle: "l2",
        }
      end

      def metadata_init(lang, script, labels)
        @meta = Metadata.new(lang, script, labels)
      end

      def make_body(xml, docxml)
        body_attr = { lang: "EN-US", link: "blue", vlink: "#954F72" }
        xml.body **body_attr do |body|
          make_body1(body, docxml)
          make_body2(body, docxml)
          make_body3(body, docxml)
        end
      end

      #def generate_header(filename, dir)
        #return unless @header
        #template = Liquid::Template.parse(File.read(@header, encoding: "UTF-8"))
        #meta = @meta.get
        #meta[:filename] = filename
        #params = meta.map { |k, v| [k.to_s, v] }.to_h
        #File.open("header.html", "w") { |f| f.write(template.render(params)) }
        #@files_to_delete << "header.html"
        #"header.html"
      #end
    end
  end
end
