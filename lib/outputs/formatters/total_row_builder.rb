class TotalRowBuilder < StoreAccess
  def perform
    [
      "TOTAL",
      total_jobs,
      totals_by_job_category,
      total_unknown_jobs
    ].flatten
  end

  private

  def total_jobs
    store.jobs_by_continent.map do |_, stats|
      stats.values.sum
    end.sum
  end

  def totals_by_job_category
    store.unique_job_categories.map do |job_category|
      store.jobs_by_continent.sum {|_, stats| stats[job_category] }
    end
  end

  def total_unknown_jobs
    store.jobs_by_continent.sum {|_, stats| stats["Autre"] }
  end
end
