
task :update_subdivision_structure do
  require 'yaml'
  require 'pry'

  d = Dir['lib/countries/data/subdivisions/*.yaml']
  d.each do |file|
    puts "checking : #{file}"
    data = YAML.load_file(file)

    data = data.each_with_object({}) do |(k, subd), a|
      a[k] ||= {}
      a[k]['unofficial_names'] = subd.delete('names')
      a[k]['translations'] = { 'en' => subd['name'] }
      a[k]['geo'] = {
        'latitude' => subd.delete('latitude'),
        'longitude' => subd.delete('longitude'),
        'min_latitude' => subd.delete('min_latitude'),
        'min_longitude' => subd.delete('min_longitude'),
        'max_latitude' => subd.delete('max_latitude'),
        'max_longitude' => subd.delete('max_longitude')
      }

      a[k] = a[k].merge(subd)
    end
    File.open(file, 'w') { |f| f.write data.to_yaml }
    begin
  rescue
    puts "failed to read #{file}: #{$ERROR_INFO}"
  end
  end
end


