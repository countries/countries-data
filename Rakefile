require "bundler/gem_tasks"
require 'active_support'
require 'active_support/core_ext'

ISO3166_ROOT_PATH = File.dirname(__FILE__)

def country_path(alpha2)
  File.join(ISO3166_ROOT_PATH, "lib", "countries_data", "local_data", "countries", "#{alpha2}.yaml")
end

def load_country_yaml(alpha2)
  YAML.load_file(country_path(alpha2))
end

def save_country_yaml(alpha2, data)
  File.open(country_path(alpha2), "w+") { |f| f.write data.to_yaml }
end

def country_codes
  @country_codes ||= Dir["lib/countries_data/local_data/countries/*.yaml"].map { |x| File.basename(x, File.extname(x)) }.uniq
end

Dir.glob("lib/countries_data/tasks/*.rake").each { |r| load r }
