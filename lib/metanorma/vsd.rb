require "metanorma"
require "metanorma/vsd/processor"

module Metanorma
  module Vsd
    ORGANIZATION_NAME = "Vita Green"
  end
end

Metanorma::Registry.instance.register(Metanorma::Vsd::Processor)
