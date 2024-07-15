# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Input, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with hint text' => true,
    'with error message' => true,
    'with width-2 class' => true,
    'with width-3 class' => true,
    'with width-4 class' => true,
    'with width-5 class' => true,
    'with width-10 class' => true,
    'with width-20 class' => true,
    'with width-30 class' => true,
    'with label as page heading' => true,
    'with optional form-group classes' => true,
    'with autocomplete attribute' => true,
    'disabled' => true,
    'with pattern attribute' => true,
    'with spellcheck enabled' => true,
    'with spellcheck disabled' => true,
    'with autocapitalize turned off' => true,
    'with prefix' => true,
    'with suffix' => true,
    'with prefix and suffix' => true,
    'with prefix and long suffix' => true,
    'with prefix and suffix and error' => true,
    'with prefix and suffix and width modifier' => true,
    'with extra letter spacing' => true,
    'classes' => true,
    'custom type' => true,
    'value' => true,
    'zero value' => true,
    'with describedBy' => true,
    'attributes' => true,
    'hint with describedBy' => true,
    'error with describedBy' => true,
    'with error and hint' => true,
    'with error, hint and describedBy' => true,
    'inputmode' => true,
    'with prefix with html as text' => true,
    'with prefix with html' => true,
    'with prefix with classes' => true,
    'with prefix with attributes' => true,
    'with suffix with html as text' => true,
    'with suffix with html' => true,
    'with suffix with classes' => true,
    'with suffix with attributes' => true,
    'with customised input wrapper' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'input')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'input').each do |fixture|
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
