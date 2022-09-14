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
    @store = Store.new
  end

  def check_csv_files
    ProfessionsCheck.new(store).perform
    JobsCheck.new(store).perform
  end

  def process_professions
    ProfessionsProcessor.new(store).perform
  end

  def process_jobs
    JobsProcessor.new(store).perform
  end

  def display_results
    Formatter.new(store).perform
    Printer.new(store).perform
  end
end
