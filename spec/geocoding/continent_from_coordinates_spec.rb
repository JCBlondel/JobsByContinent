require 'spec_helper'

RSpec.describe ContinentFromCoordinates do
  let(:service) { described_class.new }
  let(:continents_as_polygons) { ContinentsAsPolygons.new }

  describe 'attributes' do
    it { is_expected.to(have_attr_reader(:continents)) }
  end

  describe '#initialize' do
    it do
      allow(ContinentsAsPolygons).to receive(:new).and_return(continents_as_polygons)
      allow(continents_as_polygons).to receive(:perform).and_call_original
      service

      expect(continents_as_polygons).to have_received(:perform).exactly(1).time
    end
  end

  describe '#perform(lat:, lon:)' do
    let(:frenchy) { { lat: 48.1392154, lon: 11.5781413 } }
    let(:alger) { { lat: 36.7762, lon: 3.05997 } }
    let(:montreal) { { lat: 45.40, lon: -73.43 } }
    let(:mexico) { { lat: 19.37, lon: -99.21 } }
    let(:bogota) { { lat: 4.615315770816592, lon: -74.0642569282822 } }
    let(:the_thing) { { lat: -64.7700000, lon: -64.0500000 } }
    let(:izmir) { { lat: 38.39547, lon: 27.11603 } }
    let(:le_caire) { { lat: 30.02542, lon: 31.23223 } }
    let(:brisbane) { { lat: -27.47122, lon: 153.02602 } }
    let(:wellington) { { lat: -41.29494, lon: 174.77544 } }

    it do
      expect(service.perform(lat: frenchy[:lat], lon: frenchy[:lon])).to eq("EUROPE")
      expect(service.perform(lat: alger[:lat], lon: alger[:lon])).to eq("AFRICA")
      expect(service.perform(lat: montreal[:lat], lon: montreal[:lon])).to eq("NORTH AMERICA")
      expect(service.perform(lat: mexico[:lat], lon: mexico[:lon])).to eq("NORTH AMERICA")
      expect(service.perform(lat: bogota[:lat], lon: bogota[:lon])).to eq("SOUTH AMERICA")
      expect(service.perform(lat: the_thing[:lat], lon: the_thing[:lon])).to eq("ANTARCTICA")
      expect(service.perform(lat: izmir[:lat], lon: izmir[:lon])).to eq("ASIA")
      expect(service.perform(lat: le_caire[:lat], lon: le_caire[:lon])).to eq("AFRICA")
      expect(service.perform(lat: brisbane[:lat], lon: brisbane[:lon])).to eq("OCEANIA")
    end

    it "is not inside one of the polygons" do
      expect(service.perform(lat: wellington[:lat], lon: wellington[:lon])).to eq("OCEANIA")
    end

    it do
      expect(service.perform(lat: nil, lon: nil)).to eq("UNKNOWN")
    end
  end
end
