class ContinentFromCoordinates
  attr_reader :continents

  def initialize
    @continents = ContinentsAsPolygons.new.perform
  end

  def perform(lat:, lon:)
    location = Geokit::LatLng.new(lat, lon)

    continents.each do |continent_name, polygons|
      return continent_name if polygons.any? { |polygon| polygon.contains?(location) }
    end

    polygons_fallback
  end

  private

  def polygons_fallback
    "OCEANIA"
  end
end
