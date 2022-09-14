require 'spec_helper'

RSpec.describe TotalRowBuilder do
  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:service) { described_class.new(store) }

    before do
      ProfessionsProcessor.new(store).perform
      JobsProcessor.new(store).perform
    end

    let(:expected_output) do
      ["TOTAL", 5069, 1439, 411, 175, 536, 212, 782, 1445, 69]
    end

    it do
      expect(service.perform).to eq(expected_output)
    end
  end
end
