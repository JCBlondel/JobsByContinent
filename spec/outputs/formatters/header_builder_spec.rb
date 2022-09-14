require 'spec_helper'

RSpec.describe HeaderBuilder do
  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:service) { described_class.new(store) }

    before do
      ProfessionsProcessor.new(store).perform
    end

    let(:expected_output) do
      ["     ", "TOTAL", "TECH", "ADMIN", "CONSEIL", "RETAIL", "CRÉA", "MARKETING / COMM'", "BUSINESS", "AUTRE"]
    end

    it do
      expect(service.perform).to eq(expected_output)
    end
  end
end
