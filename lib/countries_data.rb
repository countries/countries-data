module CountriesData
  VERSION = '0.1.0'.freeze

  # The path that will be used for loading the Countries data. The
  # default location is __FILE__/../../../../data, which is where the data
  # lives in the gem installation of the mime-types-data library.
  #
  PATH = File.expand_path('countries/compiled_data', __FILE__)
end
