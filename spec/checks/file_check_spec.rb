require 'spec_helper'

class ChildClass < FileCheck
end

RSpec.describe FileCheck do
  let(:store) { Store.new }

  describe 'inheritance' do
    it { expect(described_class).to be < StoreAccess }
  end

  describe '#perform' do
    describe '#path?' do
      it do
        child_class = ChildClass.new(store)

        expect do
          child_class.perform
        end.to raise_error("#{child_class.class} #path method is not implemented.")
      end
    end

    describe '#required_extension' do
      it do
        child_class = ChildClass.new(store)
        allow(child_class).to receive(:path).and_return("spec/fixtures/professions.not_a_csv")

        expect do
          child_class.perform
        end.to raise_error("File 'spec/fixtures/professions.not_a_csv' has not the .csv extension.")
      end
    end

    describe '#required_header' do
      it do
        child_class = ChildClass.new(store)
        allow(child_class).to receive(:path).and_return("spec/fixtures/professions.csv")

        expect do
          child_class.perform
        end.to raise_error("#{child_class.class} #required_header method is not implemented.")
      end
    end
  end
end
