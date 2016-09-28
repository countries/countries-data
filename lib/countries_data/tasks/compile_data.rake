desc 'Update Cache'
task :update_cache do
  require 'yaml'
  require 'i18n_data'

  codes = Dir['lib/countries/data/countries/*.yaml'].map { |x| File.basename(x, File.extname(x)) }.uniq
  data = {}

  corrections = YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'translation_corrections.yaml')) || {}

  I18nData.languages.keys.each do |locale|
    locale = locale.downcase
    begin
      local_names = I18nData.countries(locale)
    rescue I18nData::NoTranslationAvailable
      next
    end

    # Apply any known corrections to i18n_data
    unless corrections[locale].nil?
      corrections[locale].each do |alpha2, localized_name|
        local_names[alpha2] = localized_name
      end
    end

    File.open(File.join(File.dirname(__FILE__), 'lib', 'countries', 'cache', 'locales', "#{locale}.json"), 'wb') { |f| f.write(local_names.to_json) }
  end

  codes.each do |alpha2|
    data[alpha2] ||= YAML.load_file(File.join(File.dirname(__FILE__), 'lib', 'countries', 'data', 'countries', "#{alpha2}.yaml"))[alpha2]
  end

  File.open(File.join(File.dirname(__FILE__), 'lib', 'countries', 'cache', 'countries.json'), 'wb') { |f| f.write(data.to_json) }
end