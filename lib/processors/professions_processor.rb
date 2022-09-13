class ProfessionsProcessor < StoreAccess
  def perform
    iterate_through_professions
  end

  private

  def iterate_through_professions
    profession_chunks.each do |professions|
      worker_results = ProfessionsChunkWorker.new.perform(professions)
      store.professions.merge!(worker_results[:professions])
    end
  end

  def profession_chunks
    SmarterCSV.process(store.professions_csv_file, chunk_size: 1000)
  end
end
