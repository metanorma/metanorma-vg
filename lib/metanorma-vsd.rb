require "metanorma"
require 'metanorma/acme'

Metanorma::Acme.configure do |config|
  config.organization_name_long = config.organization_name_short = 'Vita Green'
  config.document_namespace = 'https://open.ribose.com/standards/vsd'
  html_configs = File.join(File.expand_path('config', __dir__), 'vsd_html.yml')
  isodoc_vsd_html_folder = File.join(File.expand_path('isodoc', __dir__),
                                     'vsd',
                                     'html')
  config.wordstylesheet = File.join(isodoc_vsd_html_folder, "wordstyle.scss")
  config.standardstylesheet = File.join(isodoc_vsd_html_folder, "vsd.scss")
  config.header = File.join(isodoc_vsd_html_folder, "header.html")
  config.wordcoverpage = File.join(isodoc_vsd_html_folder,
                                   "word_vsd_titlepage.html")
  config.wordintropage = File.join(isodoc_vsd_html_folder,
                                   "word_vsd_intro.html")
  config.htmlstylesheet = File.join(isodoc_vsd_html_folder,
                                    "htmlstyle.scss")
  config.htmlcoverpage = File.join(isodoc_vsd_html_folder,
                                   "html_vsd_titlepage.html")
  config.htmlintropage = File.join(isodoc_vsd_html_folder,
                                   "html_vsd_intro.html")
  config.scripts = File.join(isodoc_vsd_html_folder, "scripts.html")
  config.xml_root_tag = 'vsd-standard'
end
require "metanorma/vsd"
require "isodoc/acme"

require "asciidoctor" unless defined? Asciidoctor::Converter
require "asciidoctor/vsd"
