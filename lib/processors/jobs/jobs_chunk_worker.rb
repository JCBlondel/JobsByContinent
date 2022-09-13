class JobsChunkWorker
  attr_reader :worker_results

  def initialize
    @worker_results = {}
  end

  def perform(jobs)
    jobs.each do |job|
      # JobGeocoder -> get the continent
      # CategoryMatcher -> get the matching category_name
      #
      # in worker_results -> category_name (key) increment value
    end

    worker_results
  end
end
