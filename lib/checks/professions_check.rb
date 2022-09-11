class ProfessionsCheck < FileCheck
  private

  def required_header
    "id,name,category_name\n"
  end

  def path
    store.professions_csv_file
  end
end
