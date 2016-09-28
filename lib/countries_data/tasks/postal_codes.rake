require 'uri'
require 'net/http'
require 'json'

def fetch_postal_data_for_alpha2(alpha2)
  url = URI("http://i18napis.appspot.com/address/data/#{alpha2}")

  http = Net::HTTP.new(url.host, url.port)
  request = Net::HTTP::Get.new(url)
  response = http.request(request)
  JSON.parse(response.read_body)
end

namespace :postal do
  desc 'Retrieve and store subdivisions coordinates'
  task :fetch do
    require 'countries'
    # Iterate over countries
    ISO3166::Country.all.each do |country|
      code = country.alpha2
      # Load unmutated yaml file.
      data = load_country_yaml(country.alpha2)

      data[code]['postal_address_data'] = fetch_postal_data_for_alpha2(code.upcase)
      # Persist
      save_country_yaml(code, data)
    end
  end
end