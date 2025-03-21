# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::FileUpload, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'allows multiple files' => true,
    'allows image files only' => true,
    'allows direct media capture' => true,
    'disabled' => true,
    'with hint text' => true,
    'with error message and hint' => true,
    'with label as page heading' => true,
    'with optional form-group classes' => true,
    'enhanced' => true,
    'enhanced, disabled' => true,
    'enhanced, with error message and hint' => true,
    'translated' => true,
    'with value' => false,
    'attributes' => true,
    'classes' => true,
    'id' => true,
    'with describedBy' => true,
    'with hint and describedBy' => true,
    'error' => true,
    'with error and describedBy' => true,
    'with error, describedBy and hint' => true,
    'translated, no javascript enhancement' => true,
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
