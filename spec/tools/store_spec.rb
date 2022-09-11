require 'spec_helper'

RSpec.describe Store do
  let(:store) { described_class.new }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:professions_csv_file)) }
    it { is_expected.to(have_attr_reader(:jobs_csv_file)) }

    it { is_expected.to(have_attr_accessor(:professions)) }
    it { is_expected.to(have_attr_accessor(:categories)) }
    it { is_expected.to(have_attr_accessor(:jobs_by_continent)) }
  end

  describe '#initialize' do
    it { expect(store.professions_csv_file).to eq('data/professions.csv') }
    it { expect(store.jobs_csv_file).to eq('data/jobs.csv') }

    it { expect(store.professions).to match({}) }
    it { expect(store.categories).to match([]) }
    it { expect(store.jobs_by_continent).to match({}) }
  end
end
