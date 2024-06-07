# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::FileUpload, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with hint text' => true,
    'with error message and hint' => true,
    'with value' => false,
    'with label as page heading' => true,
    'with optional form-group classes' => true,
    'attributes' => true,
    'classes' => true,
    'with describedBy' => true,
    'with hint and describedBy' => true,
    'error' => true,
    'with error and describedBy' => true,
    'with error, describedBy and hint' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'file-upload')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'file-upload').each do |fixture|
    if fixture_list[fixture]
      it "has spec'd the '#{fixture}' fixture" do
        expect(fixture_list).to have_key(fixture)
        expect(tested_fixtures).to include(fixture)
      end
    else
      it "has skipped the '#{fixture}' fixture" do
        expect(fixture_list).to have_key(fixture)
        expect(tested_fixtures).not_to include(fixture)
      end
    end
  end
end
