# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend do
  describe 'created components are loaded in' do
    Dir['lib/ccs/frontend_helpers/govuk_frontend/**/*.rb'].each do |helper_module_file|
      helper_module = helper_module_file[4..-4].camelize.gsub('Ccs', 'CCS').gsub('Govuk', 'GovUK').constantize

      it "includes the #{helper_module} module" do
        expect(described_class).to include(helper_module)
      end
    end
  end

  describe 'all GOV.UK Frontend components are created' do
    Dir["#{FixturesLoader::FIXTURES_PATH}/**/macro.njk"].each do |helper_module_file|
      helper_module = "CCS::FrontendHelpers::GovUKFrontend::#{helper_module_file[(FixturesLoader::FIXTURES_PATH.length + 1)...-10].gsub('-', '_').camelize}"

      it "includes the #{helper_module} module from GOV.UK" do
        helper_module.constantize
        expect(described_class).to include(helper_module.constantize)
      rescue StandardError
        raise "Helper '#{helper_module}' not yet created"
      end
    end
  end
end
