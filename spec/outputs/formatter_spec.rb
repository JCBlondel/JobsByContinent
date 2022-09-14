require 'spec_helper'

RSpec.describe Formatter do
  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:service) { described_class.new(store) }

    before do
      allow(store).to receive(:jobs_csv_file).and_return("spec/fixtures/jobs.csv")
      allow(store).to receive(:jobs_csv_file).and_return("spec/fixtures/professions.csv")

      ProfessionsProcessor.new(store).perform
      JobsProcessor.new(store).perform
    end

    let(:expected_output) do
      [
        ["       ", "TOTAL", "TECH", "ADMIN", "CONSEIL", "RETAIL", "CRÉA", "MARKETING / COMM'", "BUSINESS", "AUTRE"],
        ["TOTAL", 1, 0, 0, 0, 0, 0, 0, 0, 1],
        ["UNKNOWN", 1, 0, 0, 0, 0, 0, 0, 0, 1]
      ]
    end

    it do
      expect { service.perform }
        .to change { store.formatted_output }.from([]).to(expected_output)
    end
  end
end
