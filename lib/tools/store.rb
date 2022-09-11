class Store
  attr_reader :professions_csv_file
  attr_reader :jobs_csv_file

  attr_accessor :professions
  attr_accessor :categories
  attr_accessor :jobs_by_continent

  def initialize
    @professions_csv_file = professions_csv_file_path
    @jobs_csv_file = jobs_csv_file_path

    @professions = {}
    @categories = []
    @jobs_by_continent = {}
  end

  private

  def professions_csv_file_path
    'data/professions.csv'
  end

  def jobs_csv_file_path
    'data/jobs.csv'
  end
end
