require 'spec_helper'

RSpec.describe StatsAggregator do
  let(:service) { described_class.new }
  let(:store) { Store.new }
  let(:main_stats) { store.jobs_by_continent }
  let(:new_stats) do
    {
      "EUROPE"=> { "Tech"=> 1, "Market"=> 2, "Autre"=> 3 },
      "ANTARCTICA"=> { "Autre"=> 12 },
    }
  end
  let(:new_stats_2) do
    {
      "EUROPE"=> { "Tech"=> 1 },
    }
  end
  let(:new_stats_3) do
    {
      "ANTARCTICA"=> { "Autre"=> 1 },
    }
  end
  let(:expected_output) do
    {
      "EUROPE"=> { "Tech"=> 2, "Market"=> 2, "Autre"=> 3 },
      "ANTARCTICA"=> { "Autre"=> 13 },
    }
  end

  describe '#perform(main_stats, new_stats)' do
    it do
      expect(main_stats).to eq({})

      service.perform(main_stats, new_stats)
      service.perform(main_stats, new_stats_2)
      service.perform(main_stats, new_stats_3)

      expect(main_stats).to eq(expected_output)
    end
  end
end
