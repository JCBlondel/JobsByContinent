class JobsCheck < FileCheck
  private

  def required_header
    "profession_id,contract_type,name,office_latitude,office_longitude\n"
  end

  def path
    store.jobs_csv_file
  end
end
