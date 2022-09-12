require 'spec_helper'

RSpec.describe ProfessionsProcessor do
  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:service) { described_class.new(store) }

    it do
      allow(store).to receive(:professions_csv_file).and_return('spec/fixtures/professions.csv')

      expect { service.perform }
        .to change { store.professions }.from({}).to({17 => "Tech"})
        .and change { store.categories }.from([]).to(["Tech"])
    end
  end
end
