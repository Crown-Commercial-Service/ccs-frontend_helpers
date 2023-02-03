# CCS Frontend Helpers

![Test Status](https://github.com/tim-s-ccs/ccs-frontend_helpers/actions/workflows/main.yml/badge.svg)

The Crown Marketplace Utilities gem was created for use in the Crown Marketplace projects at the Crown Commercial Service.
This project contains two applications (both use the Ruby on Rails framework):
- [Crown Marketplace](https://github.com/Crown-Commercial-Service/crown-marketplace)
- [Crown Marketplace Legacy](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy)

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ccs-frontend_helpers

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ccs-frontend_helpers

## Usage

To use this gem, simply add it to your Gemfile (as described above).

## Helpers

To include the helper methods from the `GovUKFrontend` and `CCSFrontend` module, you can include the `CCS::FrontendHelpers` module in your `app/helpers/application_helper.rb` file like so:

```ruby
module ApplicationHelper
  include CCS::FrontendHelpers
end 
```

This will give you access to a variety of [GDS components](https://design-system.service.gov.uk/components) and [CCS components](https://github.com/tim-s-ccs/ts-ccs-frontend) to use in your application views.
The `GovUKFrontend` components are based on the components found in [GOV.UK Frontend v4.3.1](https://github.com/alphagov/govuk-frontend/releases/tag/v4.3.1).

Documentation for the helper methods can be found at [LINK TO RDOCS](#)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tim-s-ccs/ccs-frontend_helpers.

## Licence

The gem is available as open source under the terms of the [MIT Licence](https://opensource.org/licenses/MIT).
