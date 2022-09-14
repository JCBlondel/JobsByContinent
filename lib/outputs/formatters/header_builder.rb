class HeaderBuilder < StoreAccess
  def perform
    [
      header_first_cell,
      "TOTAL",
      store.unique_job_categories.map(&:upcase),
      "AUTRE"
    ].flatten
  end

  private

  def first_cell_width
    return minimal_width if store.jobs_by_continent.empty?

    store.jobs_by_continent
      .keys.sort_by(&:length)
      .last.size
  end

  def header_first_cell
    " " * first_cell_width
  end

  def minimal_width
    "TOTAL".size
  end
end
