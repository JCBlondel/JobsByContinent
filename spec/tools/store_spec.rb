require 'spec_helper'

RSpec.describe Store do
  let(:store) { described_class.new }
  let(:continent_from_coordinates) { ContinentFromCoordinates.new }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:professions_csv_file)) }
    it { is_expected.to(have_attr_reader(:jobs_csv_file)) }

    it { is_expected.to(have_attr_reader(:geocoder_service)) }

    it { is_expected.to(have_attr_accessor(:professions)) }
    it { is_expected.to(have_attr_accessor(:jobs_by_continent)) }
    it { is_expected.to(have_attr_accessor(:formatted_output)) }
  end

  describe '#initialize' do
    it { expect(store.professions_csv_file).to eq('data/professions.csv') }
    it { expect(store.jobs_csv_file).to eq('data/jobs.csv') }

    it do
      allow(ContinentFromCoordinates).to receive(:new).and_return(continent_from_coordinates)

      expect(store.geocoder_service).to eq(continent_from_coordinates)
    end

    it { expect(store.professions).to match({}) }
    it { expect(store.jobs_by_continent).to match({}) }
    it { expect(store.formatted_output).to match([]) }
  end
end
