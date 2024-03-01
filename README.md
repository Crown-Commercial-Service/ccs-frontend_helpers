# CCS Frontend Helpers

[![Ruby](https://github.com/tim-s-ccs/ccs-frontend_helpers/actions/workflows/main.yml/badge.svg)](https://github.com/tim-s-ccs/ccs-frontend_helpers/actions/workflows/main.yml)
[![Gem Version](https://badge.fury.io/rb/ccs-frontend_helpers.svg)](https://badge.fury.io/rb/ccs-frontend_helpers)

The CCS Frontend Helpers gem was created for use in the Crown Marketplace projects at the Crown Commercial Service.
This project contains two applications (both use the Ruby on Rails framework):
- [Crown Marketplace](https://github.com/Crown-Commercial-Service/crown-marketplace)
- [Crown Marketplace Legacy](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy)

## Compatibility

The following table shows the version of CCS Frontend Helpers that you should use for your targeted version of GOV.UK Frontend:

| CCS Frontend Helpers Version | Target GOV.UK Frontend Version |
| ----------------------------- | ------------------------------ |
| [0.1.2](https://github.com/tim-s-ccs/ccs-frontend_helpers/releases/tag/v0.1.2) | [4.7.0](https://github.com/alphagov/govuk-frontend/releases/tag/v4.7.0) |

Any other versions of GOV.UK Frontend not shown above _may_ still be compatible, but have not been specifically tested and verified.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ccs-frontend_helpers

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ccs-frontend_helpers

## Usage

To use this gem, simply add it to your Gemfile (as described above).

### Helpers

To include the helper methods from the `GovUKFrontend` and `CCSFrontend` module, you can include the `CCS::FrontendHelpers` module in your `app/helpers/application_helper.rb` file like so:

```ruby
module ApplicationHelper
  include CCS::FrontendHelpers
end 
```

This will give you access to a variety of [GDS components](https://design-system.service.gov.uk/components) and [CCS components](https://github.com/tim-s-ccs/ts-ccs-frontend) to use in your application views.
The `GovUKFrontend` components are based on the components found in [GOV.UK Frontend v4.5.0](https://github.com/alphagov/govuk-frontend/releases/tag/v4.5.0).

Documentation for the helper methods can be found at [LINK TO RDOCS](#)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Linting

The [rubocop](https://github.com/rubocop-hq/rubocop) & [rubocop-rspec](https://github.com/rubocop-hq/rubocop-rspec) gems are used to enforce standard coding styles.
Some "cops" in the standard configuration have been disabled or adjusted in [`.rubocop.yml`](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy/blob/master/.rubocop.yml).
Rubocop linting is run as part of the default Rake task, but can be run individually using `rake rubocop`.

### Testing

#### Unit testing
There is an automated RSpec-based test suite.

You can run all the unit tests with:
```shell
bundle exec rake
```

To run a specific unit test, use:
```shell
bundle exec rspec /path/to/file_spec.rb
```

All the specs are run as part of the Pull Request process.

### Code coverage

Code coverage is measured by [simplecov](https://github.com/simplecov-ruby/simplecov)

After running the Rspec tests, open [coverage/index.html](coverage/index.html) in a browser to see the code coverage percentage.

### Managing dependencies
 
We use [dependabot](https://github.com/dependabot) and [Snyk](https://app.snyk.io/org/ccs-wattsa) to help manage our dependencies.

We schedule `dependabot` to run every Sunday night which will get the latest dependency updates.
 
Snyk is used more for analysing security issues and it will raise PRs itself for a developer to analyse.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tim-s-ccs/ccs-frontend_helpers.

To contribute to the project, you should checkout a new branch from `main` and make your changes.

Before pushing to the remote, you should squash your commits into a single commit.
This can be done using `git rebase -i main` and changing `pick` to `s` for the commits you want to squash (usually all but the first).
This is not required but it helps keep the commit history fairly neat and tidy

Once you have pushed your changes, you should open a Pull Request on the main branch.
This will run:
- Rubocop
- Unit tests

Once all these have passed, and the PR has been reviewed and approved by another developer, you can merge the PR.

## Licence

The gem is available as open source under the terms of the [MIT Licence](https://opensource.org/licenses/MIT).
