# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend'

RSpec.describe CCS::FrontendHelpers::CCSFrontend do
  describe 'created components are loaded in' do
    Dir['lib/ccs/frontend_helpers/ccs_frontend/**/*.rb'].each do |helper_module_file|
      helper_module = helper_module_file[4..-4].camelize.gsub('Ccs', 'CCS').constantize

      it "includes the #{helper_module} module" do
        expect(described_class).to include(helper_module)
      end
    end
  end

  describe 'all CCS Frontend components are created' do
    Dir["#{FixturesLoader::FIXTURE_PATHS[:ccs_frontend]}/**/macro.njk"].each do |helper_module_file|
      helper_module = "CCS::FrontendHelpers::CCSFrontend::#{helper_module_file[(FixturesLoader::FIXTURE_PATHS[:ccs_frontend].length + 1)...-10].gsub('-', '_').camelize}"

      it "includes the #{helper_module} module from CCS" do
        helper_module.constantize
        expect(described_class).to include(helper_module.constantize)
      rescue StandardError
        raise "Helper '#{helper_module}' not yet created"
      end
    end
  end
end
