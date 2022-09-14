class JobsProcessor < StoreAccess
  def perform
    iterate_through_jobs
  end

  private

  def iterate_through_jobs
    jobs_chunks.each do |jobs|
      worker_results = JobsChunkWorker.new(store).perform(jobs)

      StatsAggregator.new.perform(store.jobs_by_continent, worker_results)
    end
  end

  def jobs_chunks
    SmarterCSV.process(store.jobs_csv_file, chunk_size: 1000)
  end
end
