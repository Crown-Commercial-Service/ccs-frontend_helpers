# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::DateInput, '#validate_fixtures', type: :helper do
  component_name = 'date-input'
  fixture_list = {
    'default' => true,
    'day and month' => true,
    'month and year' => true,
    'with errors only' => true,
    'with errors and hint' => true,
    'with error on day input' => false,
    'with error on month input' => false,
    'with error on year input' => false,
    'with items' => true,
    'with optional form-group classes' => true,
    'with autocomplete values' => true,
    'with input attributes' => true,
    'classes' => true,
    'attributes' => true,
    'with empty items' => true,
    'custom pattern' => true,
    'custom inputmode' => true,
    'with nested name' => true,
    'with id on items' => true,
    'suffixed id' => true,
    'with values' => true,
    'with hint and describedBy' => true,
    'with error and describedBy' => true,
    'fieldset html' => true,
    'items with classes' => true,
    'items without classes' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, component_name)

  it 'has only the tested fixtures' do
    expect(fixture_list.keys.sort).to eq(FixturesLoader.get_fixture_names(:govuk_frontend, component_name).sort)
  end

  FixturesLoader.get_fixture_names(:govuk_frontend, component_name).each do |fixture|
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
