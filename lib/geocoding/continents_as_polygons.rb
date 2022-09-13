class ContinentsAsPolygons
  attr_reader :continents_file_path
  attr_reader :continents

  def initialize
    @continents_file_path = "data/continents.yml"
    @continents = {}
  end

  def perform
    continents_data = read_yaml_data.to_a
    prepare_continents(continents_data)
    convert_data_to_polygons(continents_data)

    continents
  end

  private

  def read_yaml_data
    YAML.load_file(continents_file_path)
  end

  def prepare_continents(continents_data)
    unique_labels = continents_data.map { |continent| continent[1]["label"] }.uniq

    unique_labels.each do |label|
      continents[label] = []
    end
  end

  def convert_data_to_polygons(continents_data)
    return if continents_data.empty?

    process_one_polygon(continents_data.shift)
    convert_data_to_polygons(continents_data)
  end

  def process_one_polygon(continent_data)
    points = continent_data[1]["points"].map { |point| Geokit::LatLng.new(point[0], point[1]) }

    continents[continent_data[1]["label"]] << Geokit::Polygon.new(points)
  end
end
