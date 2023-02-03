# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend do
  Dir['lib/ccs/frontend_helpers/govuk_frontend/**/*.rb'].each do |helper_module_file|
    helper_module = helper_module_file[4..-4].camelize.gsub('Ccs', 'CCS').gsub('Govuk', 'GovUK').constantize

    it "includes the #{helper_module} module" do
      expect(described_class).to include(helper_module)
    end
  end
end
