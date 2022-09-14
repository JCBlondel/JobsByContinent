class ContinentsRowsBuilder < StoreAccess
  def perform
    store.jobs_by_continent.map do |continent, stats|
      [
        continent,
        total_for_continent(stats),
        totals_by_job_category(stats),
        total_unknown_jobs(stats),
      ].flatten
    end
  end

  private

  def total_for_continent(stats)
    stats.values.sum
  end

  def totals_by_job_category(stats)
    store.unique_job_categories.map do |job_category|
      stats[job_category]
    end
  end

  def total_unknown_jobs(stats)
    stats["Autre"]
  end
end
