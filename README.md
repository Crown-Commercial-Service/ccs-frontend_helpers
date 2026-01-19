# CCS Frontend Helpers

[![Ruby](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/actions/workflows/release.yml/badge.svg)](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/actions/workflows/release.yml)
[![Gem Version](https://badge.fury.io/rb/ccs-frontend_helpers.svg)](https://badge.fury.io/rb/ccs-frontend_helpers)

The CCS Frontend Helpers gem was created for use in the Crown Marketplace projects at the Crown Commercial Service.
This project contains two applications (both use the Ruby on Rails framework):
- [Crown Marketplace](https://github.com/Crown-Commercial-Service/crown-marketplace)
- [Crown Marketplace Legacy](https://github.com/Crown-Commercial-Service/crown-marketplace-legacy)

## Compatibility

The following table shows the version of CCS Frontend Helpers that you should use for your targeted version of GOV.UK Frontend:

| CCS Frontend Helpers Version  | Target GOV.UK Frontend Version | Target CCS Frontend Version |
| ----------------------------- | ------------------------------ | --------------------------- |
| [3.4.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v3.4.0) | [5.14.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.14.0) | [2.4.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v2.4.0) |
| [3.3.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v3.3.0) | [5.13.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.13.0) | [2.3.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v2.3.0) |
| [3.2.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v3.2.0) | [5.13.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.13.0) | [2.2.1](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v2.2.1) |
| [3.1.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v3.1.0) | [5.13.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.13.0) | [2.1.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v2.1.0) |
| [3.0.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v3.0.0) | [5.11.2](https://github.com/alphagov/govuk-frontend/releases/tag/v5.11.2) | [2.0.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v2.0.0) |
| [2.5.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v2.5.0) | [5.11.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.11.0) | [1.4.1](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.4.1) |
| [2.4.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v2.4.0) | [5.10.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.10.0) | [1.4.1](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.4.1) |
| [2.3.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v2.3.0) | [5.9.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.9.0) | [1.4.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.4.0) |
| [2.2.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v2.2.0) | [5.9.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.9.0) | [1.3.3](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.3.3) |
| [2.1.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v2.1.0) | [5.7.1](https://github.com/alphagov/govuk-frontend/releases/tag/v5.7.1) | [1.3.2](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.3.2) |
| [2.0.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v2.0.0) | [5.7.1](https://github.com/alphagov/govuk-frontend/releases/tag/v5.7.1) | [1.2.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.2.0) |
| [1.2.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v1.2.0) | [5.6.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.6.0) | [1.1.3](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.1.3) |
| [1.1.2](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v1.1.2) | [5.5.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.5.0) | [1.1.2](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.1.2) |
| [1.1.1](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v1.1.1) | [5.4.1](https://github.com/alphagov/govuk-frontend/releases/tag/v5.4.1) | [1.1.1](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.1.1) |
| [1.1.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v1.1.0) | [5.4.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.4.0) | [1.1.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.1.0) |
| [1.0.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v1.0.0) | [5.4.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.4.0) | [1.0.0](https://github.com/Crown-Commercial-Service/ccs-frontend-project/releases/tag/v1.0.0) |
| [0.4.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v0.4.0) | [5.4.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.4.0) | N/A |
| [0.3.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v0.3.0) | [5.3.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.3.0) | N/A |
| [0.2.0](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v0.2.0) | [5.2.0](https://github.com/alphagov/govuk-frontend/releases/tag/v5.2.0) | N/A |
| [0.1.2](https://github.com/Crown-Commercial-Service/ccs-frontend_helpers/releases/tag/v0.1.2) | [4.7.0](https://github.com/alphagov/govuk-frontend/releases/tag/v4.7.0) | N/A |

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

This will give you access to a variety of [GDS components](https://design-system.service.gov.uk/components) and [CCS components](https://github.com/Crown-Commercial-Service/ts-ccs-frontend) to use in your application views.
The `GovUKFrontend` components are based on the components found in [GOV.UK Frontend v4.5.0](https://github.com/alphagov/govuk-frontend/releases/tag/v4.5.0).

Documentation for the helper methods can be found at [LINK TO RDOCS](#)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

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

## Releasing

1. Check out the **main** branch and pull the latest changes.

2. Update the version number in `version.rb` (we follow [Semantic Versioning](https://semver.org/)).

3. Run `bundle install` to update the `Gemfile.lock`

4. Create and check out a new branch (`release-[version]`)

  ```shell
   git switch -c "release-$(./bin/version)"
   ```

5. Update the [`CHANGELOG.md`](/CHANGELOG.md) by:

   - changing the 'Unreleased' heading to the new version number and release type. For example, '3.11.0 (Feature release)'
   - adding a new 'Unreleased' heading above the new version number and release type, so users will know where to add PRs to the changelog
   - if the changelog has headings from a pre release, regroup the content under those headings in a single block
   - saving your changes

6. Run `./bin/build-release.sh` to:

   - commit the changes
   - push a branch to GitHub

   You will now be prompted to continue or cancel. Check the details and enter `y` to continue. If something does not look right, press `N` to cancel the build and creation of the branch on GitHub.

7. Create a pull request and copy the changelog text.
   When reviewing the PR, check that the version numbers have been updated and that the compiled assets use this version number.

8. Once a reviewer approves the pull request, merge it to **main**. The gem will then automatically be published to [rubygems.org](https://rubygems.org) via a GitHub action.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Crown-Commercial-Service/ccs-frontend_helpers.

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
