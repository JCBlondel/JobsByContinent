class Store
  attr_reader :professions_csv_file
  attr_reader :jobs_csv_file

  attr_reader :geocoder_service

  attr_accessor :professions
  attr_accessor :jobs_by_continent
  attr_accessor :formatted_output

  def initialize
    @professions_csv_file = professions_csv_file_path
    @jobs_csv_file = jobs_csv_file_path

    @geocoder_service = ContinentFromCoordinates.new

    @professions = {}
    @jobs_by_continent = {}
    @formatted_output = []
  end

  def unique_job_categories
    professions.values.uniq
  end

  private

  def professions_csv_file_path
    'data/professions.csv'
  end

  def jobs_csv_file_path
    'data/jobs.csv'
  end
end
