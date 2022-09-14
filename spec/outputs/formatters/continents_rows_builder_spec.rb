require 'spec_helper'

RSpec.describe ContinentsRowsBuilder do
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
      [
        ["EUROPE", 4795, 1402, 396, 175, 426, 205, 759, 1372, 60],
        ["NORTH AMERICA", 157, 14, 9, 0, 87, 7, 12, 27, 1],
        ["AFRICA", 9, 3, 1, 0, 1, 0, 1, 3, 0],
        ["UNKNOWN", 43, 8, 4, 0, 8, 0, 6, 9, 8],
        ["ASIA", 51, 11, 1, 0, 6, 0, 3, 30, 0],
        ["SOUTH AMERICA", 5, 1, 0, 0, 0, 0, 0, 4, 0],
        ["OCEANIA", 9, 0, 0, 0, 8, 0, 1, 0, 0]
      ]
    end

    it do
      expect(service.perform).to eq(expected_output)
    end
  end
end
