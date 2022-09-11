require 'spec_helper'

RSpec.describe StoreAccess do
  let(:store) { Store.new }
  let(:store_access) { described_class.new(store) }

  describe 'attributes' do
    it { expect(store_access).to(have_attr_reader(:store)) }
  end

  describe '#initialize(store)' do
    it { expect(store_access.store).to eq(store) }
  end
end
