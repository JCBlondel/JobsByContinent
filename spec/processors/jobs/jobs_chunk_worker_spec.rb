require 'spec_helper'

RSpec.describe JobsChunkWorker do
  let(:service) { described_class.new }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:worker_results)) }
  end

  describe '#initialize' do
    it { expect(service.worker_results).to eq({}) }
  end

  describe '#perform(jobs)' do
    let(:jobs) do
      [
        {
          :profession_id => 7,
          :contract_type => "INTERNSHIP",
          :name => "[Louis Vuitton Germany] Praktikant (m/w) im Bereich Digital Retail (E-Commerce)",
          :office_latitude => 48.1392154,
          :office_longitude => 11.5781413
        }
      ]
    end
    let(:expected_output) do
      {
      }
    end

    it do
      expect(service.perform(jobs)).to eq(expected_output)
    end
  end
end
