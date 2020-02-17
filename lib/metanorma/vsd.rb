require "metanorma"
require "metanorma-acme"
require "metanorma/vsd/processor"

module Metanorma
  module Vsd
    ORGANIZATION_NAME_SHORT = 'Vita Green'.freeze
    ORGANIZATION_NAME_LONG = 'Vita Green'.freeze
    DOCUMENT_NAMESPACE = 'https://open.ribose.com/standards/vsd'.freeze

    class Configuration < Metanorma::Acme::Configuration
      def initialize(*args)
        self.organization_name_short ||= ORGANIZATION_NAME_SHORT
        self.organization_name_long ||= ORGANIZATION_NAME_LONG
        self.document_namespace ||= DOCUMENT_NAMESPACE
        html_configs ||= File.join(File.expand_path('config', __dir__), 'vsd_html.yml')
        isodoc_vsd_html_folder ||= File.join(File.expand_path('../isodoc', __dir__),
                                          'vsd',
                                          'html')
        self.wordstylesheet ||= File.join(isodoc_vsd_html_folder, 'wordstyle.scss')
        self.standardstylesheet ||= File.join(isodoc_vsd_html_folder, 'vsd.scss')
        self.header ||= File.join(isodoc_vsd_html_folder, 'header.html')
        self.wordcoverpage ||= File.join(isodoc_vsd_html_folder,
                                        'word_vsd_titlepage.html')
        self.wordintropage ||= File.join(isodoc_vsd_html_folder,
                                        'word_vsd_intro.html')
        self.htmlstylesheet ||= File.join(isodoc_vsd_html_folder,
                                          'htmlstyle.scss')
        self.htmlcoverpage ||= File.join(isodoc_vsd_html_folder,
                                        'html_vsd_titlepage.html')
        self.htmlintropage ||= File.join(isodoc_vsd_html_folder,
                                        'html_vsd_intro.html')
        self.scripts ||= File.join(isodoc_vsd_html_folder, 'scripts.html')
        self.logo_path ||= File.join(isodoc_vsd_html_folder, 'logo.png')
        self.xml_root_tag ||= 'vsd-standard'
        vsd_rng_folder ||= File.join(File.expand_path('../asciidoctor', __dir__), 'vsd')
        self.validate_rng_file ||= File.join(vsd_rng_folder, 'vsd.rng')
        super
      end
    end

    class << self
      extend Forwardable

      attr_accessor :configuration

      Configuration::CONFIG_ATTRS.each do |attr_name|
        def_delegator :@configuration, attr_name
      end

      def configure
        self.configuration ||= Configuration.new
        yield(configuration)
      end
    end

    configure {}
  end
end
Metanorma::Registry.instance.register(Metanorma::Vsd::Processor)
