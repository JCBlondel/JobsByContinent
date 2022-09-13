require 'geokit'
require 'pry'
require 'smarter_csv'

$LOAD_PATH.unshift(File.expand_path(".", "lib"))

require 'jobs_by_continent'

require 'tools/store'
require 'tools/store_access'

require 'checks/file_check'
require 'checks/professions_check'
require 'checks/jobs_check'

require 'geocoding/continent_from_coordinates'
require 'geocoding/continents_as_polygons'

require 'processors/professions_processor'
require 'processors/professions/professions_chunk_worker'
require 'processors/professions/jobs_by_continent_builder'

require 'processors/jobs_processor'
require 'processors/jobs/jobs_chunk_worker'
require 'processors/jobs/job_geocoder'
require 'processors/jobs/category_matcher'
require 'processors/jobs/jobs_by_continent_incrementor'

require 'outputs/formatter'
require 'outputs/printer'
