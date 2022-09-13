require 'spec_helper'

RSpec.describe JobsProcessor do
  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:service) { described_class.new(store) }

    xit do
      allow(store).to receive(:jobs_csv_file).and_return('spec/fixtures/jobs.csv')
    end
  end
end
