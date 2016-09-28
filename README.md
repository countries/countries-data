# CountriesData

This repo is an attempt to build a collection of meaningful country based data in yaml base format.  We will commit derivations into json, and columar (per file).   Our intent is make this repo programming language agnostic with well thought out data sets.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'countries_data'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install countries_data

## Usage

### With Ruby
Use countries-rb gem!

### With another language
All external libraries should read files from the lib/countries_data/compiled_data folder.

## Subdivisions

## Administration Level Definitions
This repo uses these definitions for subdivisions our current intent is only admin level 0 and 1.
[Definitions](http://sedac.ciesin.columbia.edu/povmap/ds_defs_admin.jsp#888)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rposborne/countries_data. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

