require 'spec_helper'

RSpec.describe JobsProcessor do
  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:service) { described_class.new(store) }

    let(:expected_output) do
      {
        "AFRICA"=>{"Autre"=>9},
        "ASIA"=>{"Autre"=>51},
        "EUROPE"=>{"Autre"=>4795},
        "NORTH AMERICA"=>{"Autre"=>157},
        "OCEANIA"=>{"Autre"=>9},
        "SOUTH AMERICA"=>{"Autre"=>5},
        "UNKNOWN"=>{"Autre"=>43}
      }
    end

    it do
      expect { service.perform }
        .to change { store.jobs_by_continent }.from({}).to(expected_output)
    end
  end
end
