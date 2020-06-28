require "isodoc"
require "metanorma-generic"
require_relative "init"

module IsoDoc
  module VG
    class PresentationXMLConvert < IsoDoc::Generic::PresentationXMLConvert
      include Init
    end
  end
end

