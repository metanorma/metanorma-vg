require "metanorma"
require "metanorma/vsd/processor"

module Metanorma
  module Vsd
  end
end

Metanorma::Registry.instance.register(Metanorma::Vsd::Processor)
