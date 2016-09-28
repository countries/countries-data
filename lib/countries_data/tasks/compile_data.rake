
def save_cache(path, data)
  [:json, :yaml].each do |type|
    typed_data = if type == :yaml
             data.to_yaml
           else
             JSON.pretty_generate data
           end

    typed_path = File.join(ISO3166_ROOT_PATH, "lib", "countries_data", "compiled_data", type.to_s, File.dirname(path))
    FileUtils.mkdir_p(typed_path)
    full_path = File.join(typed_path, File.basename(path + ".#{type}"))
    File.open(full_path, "w+") { |f| f.write typed_data }
  end
end

desc "Update Cache"
task :update_cache do
  require "yaml"
  require "i18n_data"

  data = {}

  corrections = YAML.load_file(File.join(ISO3166_ROOT_PATH, "lib", "countries_data", "local_data", "translation_corrections.yaml")) || {}

  I18nData.languages.keys.each do |locale|
    translations = {}
    locale = locale.downcase
    begin
      local_names = I18nData.countries(locale).each_with_object({}) {|(alpha2, name), names| names[alpha2] = {'official' => name, 'common' => name}}
    rescue I18nData::NoTranslationAvailable
      next
    end

    # Apply any known corrections to i18n_data
    unless corrections[locale].nil?
      corrections[locale].each do |alpha2, (type, localized_name)|
        local_names[alpha2][type] = localized_name
      end
    end

    translations['names'] = local_names

    country_codes.each do |alpha2|
      data[alpha2] ||= load_country_yaml(alpha2)[alpha2]
      data[alpha2]['translations'] ||= {}
      data[alpha2]['translations'][locale] ||= {}
      data[alpha2]['translations'][locale]['official'] = local_names[alpha2]['official']
      data[alpha2]['translations'][locale]['common'] = local_names[alpha2]['common']
    end

    save_cache("locales/#{locale}", translations)

  end

  country_codes.each do |alpha2|
    save_cache("countries/#{alpha2}", data[alpha2])
  end

  save_cache('all_countries', data)
end
