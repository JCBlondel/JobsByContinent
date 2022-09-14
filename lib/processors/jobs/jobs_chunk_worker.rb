class JobsChunkWorker < StoreAccess
  attr_reader :worker_results

  def initialize(store)
    super

    @worker_results = {}
  end

  def perform(jobs)
    jobs.each do |job|
      continent = store.geocoder_service.perform(lat: job[:office_latitude], lon: job[:office_longitude])
      category = store.professions[job[:profession_id]] || "Autre"

      increment_job_category_by_continent(continent, category)
    end

    worker_results
  end

  private

  def increment_job_category_by_continent(continent_key, category_key)
    if worker_results[continent_key].nil?
      worker_results[continent_key] = Hash.new(0)
    end

    worker_results[continent_key][category_key] += 1
  end
end
