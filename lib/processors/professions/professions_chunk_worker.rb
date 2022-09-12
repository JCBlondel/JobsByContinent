class ProfessionsChunkWorker
  attr_reader :worker_results

  def initialize
    @worker_results = { professions: {}, categories: [] }
  end

  def perform(professions)
    professions.each do |profession|
      worker_results[:professions][profession[:id]] = profession[:category_name]
      worker_results[:categories] << profession[:category_name]
    end

    worker_results
  end
end
