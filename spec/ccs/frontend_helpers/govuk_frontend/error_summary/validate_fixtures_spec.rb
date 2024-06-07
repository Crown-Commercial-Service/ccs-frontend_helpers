# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ErrorSummary, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'without links' => true,
    'mixed with and without links' => true,
    'with description only' => true,
    'with everything' => true,
    'html as titleText' => true,
    'title html' => true,
    'description' => true,
    'html as descriptionText' => true,
    'description html' => true,
    'classes' => true,
    'attributes' => true,
    'error list with attributes' => true,
    'error list with html as text' => true,
    'error list with html' => true,
    'error list with html link' => true,
    'error list with html as text link' => true,
    'autofocus disabled' => true,
    'autofocus explicitly enabled' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'error-summary')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'error-summary').each do |fixture|
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
