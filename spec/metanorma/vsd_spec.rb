require 'spec_helper'

RSpec.describe Metanorma::Vsd do
  it "has a version number" do
    expect(Metanorma::Vsd::VERSION).not_to be nil
  end
  describe '#configuration' do
    it 'has `configuration` attribute accessable' do
      expect(Metanorma::Vsd.configuration)
        .to(be_instance_of(Metanorma::Vsd::Configuration))
    end

    context 'default attributes' do
      subject(:config) { Metanorma::Vsd.configuration }
      let(:default_organization_name_short) { 'Vita Green' }
      let(:default_organization_name_long) { 'Vita Green' }
      let(:default_document_namespace) do
        'https://www.metanorma.org/ns/vsd'
      end

      it 'sets default atrributes' do
        expect(config.organization_name_short)
          .to(eq(default_organization_name_short))
        expect(config.organization_name_long)
          .to(eq(default_organization_name_long))
        expect(config.document_namespace)
          .to(eq(default_document_namespace))
      end
    end

    context 'attribute setters' do
      subject(:config) { Metanorma::Vsd.configuration }
      let(:organization_name_short) { 'Test' }
      let(:organization_name_long) { 'Test Corp.' }
      let(:document_namespace) { 'https://example.com/' }

      it 'sets atrributes' do
        Metanorma::Vsd.configure do |config|
          config.organization_name_short = organization_name_short
          config.organization_name_long = organization_name_long
          config.document_namespace = document_namespace
        end
        expect(config.organization_name_short).to eq(organization_name_short)
        expect(config.organization_name_long).to eq(organization_name_long)
        expect(config.document_namespace).to eq(document_namespace)
      end
    end
  end
end
