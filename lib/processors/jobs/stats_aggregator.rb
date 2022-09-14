class StatsAggregator
  def perform(main_stats, new_stats)
    new_stats.each do |continent, jobs_stats|
      main_stats[continent] ||= Hash.new(0)

      continent_jobs_stats_loop(main_stats[continent], jobs_stats)
    end
  end

  private

  def continent_jobs_stats_loop(continent, job_stats)
    job_stats.each do |job, stats|
      continent[job] ||= 0

      continent[job] += stats
    end
  end
end
