# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Select, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with no items' => true,
    'with selected value' => true,
    'with hint text and error message' => true,
    'with label as page heading' => true,
    'with full width override' => true,
    'with optional form-group classes' => true,
    'with describedBy' => true,
    'attributes' => true,
    'attributes on items' => true,
    'with falsy items' => false,
    'hint' => true,
    'hint and describedBy' => true,
    'error' => true,
    'error and describedBy' => true,
    'without values' => true,
    'without values with selected value' => true,
    'with falsy values' => true,
    'item selected overrides value' => false
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'select')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'select').each do |fixture|
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
