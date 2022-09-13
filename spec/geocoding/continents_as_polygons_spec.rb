require 'spec_helper'

RSpec.describe ContinentsAsPolygons do
  let(:service) { described_class.new }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:continents_file_path)) }
    it { is_expected.to(have_attr_reader(:continents)) }
  end

  describe '#initialize' do
    it { expect(service.continents_file_path).to eq("data/continents.yml") }
    it { expect(service.continents).to eq({}) }
  end

  describe '#perform' do
    it do
      continents = service.perform
      values = continents.values.flatten

      expect(continents.keys).to match(["AFRICA", "ANTARCTICA", "ASIA", "EUROPE", "NORTH AMERICA", "OCEANIA", "SOUTH AMERICA"])
      expect(values.size).to eq(9)
      expect(values.all? { |value| value.class == Geokit::Polygon }).to eq(true)
    end
  end
end
