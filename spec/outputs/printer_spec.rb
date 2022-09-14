require 'spec_helper'

RSpec.describe Printer do
  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    let(:store) { Store.new }
    let(:service) { described_class.new(store) }

    it do
      allow(Terminal::Table).to receive(:new).and_call_original

      service.perform
      expect(Terminal::Table).to have_received(:new).exactly(1).time
    end
  end
end
