require "metanorma"
require "metanorma-generic"
require "metanorma/vsd/processor"

module Metanorma
  module Vsd
    class Configuration < Metanorma::Generic::Configuration
      def initialize(*args)
        super
        html_configs ||= File.join(File.expand_path('config', __dir__), 'vsd_html.yml')
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
