require 'spec_helper'

RSpec.describe ProfessionsChunkWorker do
  let(:service) { described_class.new }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:worker_results)) }
  end

  describe '#initialize' do
    it { expect(service.worker_results).to eq({ professions: {}, categories: [] }) }
  end

  describe '#perform(professions)' do
    let(:professions) do
      [
        { :id => 17, :category_name => "Tech" },
        { :id => 24, :category_name => "Admin" }
      ]
    end
    let(:expected_output) do
      {
        :professions => {
          17 => "Tech",
          24 => "Admin"
        },
       :categories => ["Tech", "Admin"]
      }
    end

    it do
      expect(service.perform(professions)).to eq(expected_output)
    end
  end
end
