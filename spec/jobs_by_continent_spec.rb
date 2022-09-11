require 'spec_helper'

RSpec.describe JobsByContinent do
  let(:service) { described_class.new }
  let(:store) { Store.new }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:store)) }
  end

  describe '#perform' do
    it do
      allow(Store).to receive(:new).and_return(store)

      expect{ service.perform }.to change{ service.store }
        .from(nil).to(store)
    end
  end
end
