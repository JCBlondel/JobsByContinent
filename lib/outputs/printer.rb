class Printer < StoreAccess
  attr_reader :cell_width

  def perform
    table = Terminal::Table.new do |table|
      table.rows = store.formatted_output
      table.style = {
        all_separators: true,
        alignment: :center,
      }
    end

    puts table
  end
end
