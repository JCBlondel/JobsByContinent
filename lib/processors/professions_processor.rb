class ProfessionsProcessor < StoreAccess
  def perform
    iterate_through_professions
  end

  private

  def iterate_through_professions
    profession_chunks.each do |professions|
      worker_results = ProfessionsChunkWorker.new.perform(professions)
      build_professions(worker_results[:professions])
      build_categories(worker_results[:categories])
    end
  end

  def build_professions(professions)
    store.professions.merge!(professions)
  end

  def build_categories(categories)
    store.categories << categories
    store.categories.flatten!.uniq!
  end

  def profession_chunks
    SmarterCSV.process(store.professions_csv_file, chunk_size: 1000)
  end
end
