require 'spec_helper'

RSpec.describe JobsChunkWorker do
  let(:store) { Store.new }
  let(:service) { described_class.new(store) }

  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe 'attributes' do
    it { expect(service).to(have_attr_reader(:store)) }
    it { expect(service).to(have_attr_reader(:worker_results)) }
  end

  describe '#initialize(store)' do
    it { expect(service.worker_results).to eq({}) }
  end

  describe '#perform(jobs)' do
    before do
      ProfessionsProcessor.new(store).perform
    end

    let(:jobs) do
      [
        {
          :profession_id => 7,
          :office_latitude => 48.1392154,
          :office_longitude => 11.5781413
        },
        {
          :profession_id => 666,
          :name => "Exorciste",
          :office_latitude => 48.1392154,
          :office_longitude => 11.5781413
        },
        {
          :profession_id => 284,
          :office_latitude => -64.77,
          :office_longitude => -64.05
        },
        {
          :profession_id => 7,
          :office_latitude => 50.13,
          :office_longitude => 12.57
        },

      ]
    end
    let(:expected_output) do
      {
        "ANTARCTICA" => {"Autre"=>1},
        "EUROPE" => {"Autre"=>1, "Marketing / Comm'"=>2}
      }
    end

    it do
      expect(service.perform(jobs)).to eq(expected_output)
    end
  end
end
