require "isodoc"
require "isodoc/rsd/word_convert"
require_relative "metadata"

module IsoDoc
  module Vsd
    # A {Converter} implementation that generates Word output, and a document
    # schema encapsulation of the document for validation

    class WordConvert < IsoDoc::Rsd::WordConvert
      def vsd_html_path(file)
        File.join(File.dirname(__FILE__), File.join("html", file))
      end

      def initialize(options)
        super
        @wordstylesheet = generate_css(vsd_html_path("wordstyle.scss"), false, default_fonts(options))
        @standardstylesheet = generate_css(vsd_html_path("vsd.scss"), false, default_fonts(options))
        @header = vsd_html_path("header.html")
        @wordcoverpage = vsd_html_path("word_vsd_titlepage.html")
        @wordintropage = vsd_html_path("word_vsd_intro.html")
        @ulstyle = "l3"
        @olstyle = "l2"
        system "cp #{vsd_html_path('logo.png')} logo.png"
        @files_to_delete << "logo.png"
      end

      def default_fonts(options)
        b = options[:bodyfont] ||
          (options[:script] == "Hans" ? '"SimSun",serif' :
           '"Arial",sans-serif')
        h = options[:headerfont] ||
          (options[:script] == "Hans" ? '"SimHei",sans-serif' :
           '"Arial",sans-serif')
        m = options[:monospacefont] || '"Courier New",monospace'
        "$bodyfont: #{b};\n$headerfont: #{h};\n$monospacefont: #{m};\n"
      end

      def make_body(xml, docxml)
        body_attr = { lang: "EN-US", link: "blue", vlink: "#954F72" }
        xml.body **body_attr do |body|
          make_body1(body, docxml)
          make_body2(body, docxml)
          make_body3(body, docxml)
        end
      end

      def generate_header(filename, dir)
        return unless @header
        template = Liquid::Template.parse(File.read(@header, encoding: "UTF-8"))
        meta = @meta.get
        meta[:filename] = filename
        params = meta.map { |k, v| [k.to_s, v] }.to_h
        File.open("header.html", "w") { |f| f.write(template.render(params)) }
        @files_to_delete << "header.html"
        "header.html"
      end

    end
  end
end
