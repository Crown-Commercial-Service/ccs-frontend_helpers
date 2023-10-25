# frozen_string_literal: true

require_relative 'lib/ccs/frontend_helpers/version'

Gem::Specification.new do |spec|
  spec.name = 'ccs-frontend_helpers'
  spec.version = CCS::FrontendHelpers::VERSION
  spec.authors = ['tim-s-ccs']
  spec.email = ['timothy.south@crowncommercial.gov.uk']

  spec.summary = 'Gem containing view helpers for CCS Ruby on Rails projects'
  spec.description = 'Gem containing view helpers for CCS Ruby on Rails projects'
  spec.homepage = 'https://github.com/tim-s-ccs/ccs-frontend_helpers'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.0.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '>= 6.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
