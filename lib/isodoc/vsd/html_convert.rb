require "isodoc/rsd/html_convert"
require_relative "metadata"

module IsoDoc
  module Vsd

    # A {Converter} implementation that generates HTML output, and a document
    # schema encapsulation of the document for validation
    #
    class HtmlConvert < IsoDoc::Rsd::HtmlConvert
      def vsd_html_path(file)
        File.join(File.dirname(__FILE__), File.join("html", file))
      end

      def initialize(options)
        super
        @htmlstylesheet = generate_css(vsd_html_path("htmlstyle.scss"), true, default_fonts(options))
        @htmlcoverpage = vsd_html_path("html_vsd_titlepage.html")
        @htmlintropage = vsd_html_path("html_vsd_intro.html")
        @scripts = vsd_html_path("scripts.html")
        system "cp #{vsd_html_path('logo.png')} logo.png"
        @files_to_delete << "logo.png"
      end

      def default_fonts(options)
        b = options[:bodyfont] ||
          (options[:script] == "Hans" ? '"SimSun",serif' :
           '"Overpass",sans-serif')
        h = options[:headerfont] ||
          (options[:script] == "Hans" ? '"SimHei",sans-serif' :
           '"Overpass",sans-serif')
        m = options[:monospacefont] || '"Space Mono",monospace'
        "$bodyfont: #{b};\n$headerfont: #{h};\n$monospacefont: #{m};\n"
      end

      def html_head
        <<~HEAD.freeze
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!--TOC script import-->
    <script type="text/javascript" src="https://cdn.rawgit.com/jgallen23/toc/0.3.2/dist/toc.min.js"></script>
    <script type="text/javascript">
    function toclevel() { var i; var text = "";
      for(i = 1; i <= #{@htmlToClevels}; i++) {
        if (i > 1) { text += ","; } text += "h" + i + ":not(.TermNum)"; } }
    </script>

    <!--Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i|Space+Mono:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Overpass:300,300i,600,900" rel="stylesheet">
    <!--Font awesome import for the link icon-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/solid.css" integrity="sha384-v2Tw72dyUXeU3y4aM2Y0tBJQkGfplr39mxZqlTBDUZAb9BGoC40+rdFCG0m10lXk" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.8/css/fontawesome.css" integrity="sha384-q3jl8XQu1OpdLgGFvNRnPdj5VIlCvgsDQTQB6owSOHWlAurxul7f+JpUOVdAiJ5P" crossorigin="anonymous">
    <style class="anchorjs"></style>
        HEAD
      end

      def make_body(xml, docxml)
        body_attr = { lang: "EN-US", link: "blue", vlink: "#954F72", "xml:lang": "EN-US", class: "container" }
        xml.body **body_attr do |body|
          make_body1(body, docxml)
          make_body2(body, docxml)
          make_body3(body, docxml)
        end
      end

    end
  end
end

