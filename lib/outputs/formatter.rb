class Formatter < StoreAccess
  def perform
    store.formatted_output = [
      HeaderBuilder.new(store).perform,
      TotalRowBuilder.new(store).perform,
    ]

    push_continents_rows
  end

  private

  def push_continents_rows
    rows = ContinentsRowsBuilder.new(store).perform
    rows.each { |row| store.formatted_output.push(row) }
  end
end
