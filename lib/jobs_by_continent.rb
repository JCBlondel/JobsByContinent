class JobsByContinent
  attr_reader :store

  def perform
    init_store
    check_csv_files

    process_professions
    process_jobs
    display_results
  end

  private

  def init_store
  end

  def check_csv_files
  end

  def process_professions
  end

  def process_jobs
  end

  def display_results
  end
end
