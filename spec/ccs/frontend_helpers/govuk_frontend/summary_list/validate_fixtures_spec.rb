# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::SummaryList, '#validate_fixtures', type: :helper do
  component_name = 'summary-list'
  fixture_list = {
    'default' => true,
    'with actions' => true,
    'translated' => true,
    'with some actions' => true,
    'no-border' => true,
    'no-border on last row' => true,
    'overridden-widths' => true,
    'extreme' => true,
    'as a summary card with a text header' => true,
    'as a summary card with a custom header level' => true,
    'as a summary card with a html header' => true,
    'as a summary card with actions' => true,
    'as a summary card with actions plus summary list actions' => true,
    'as a summary card extreme' => true,
    'attributes' => true,
    'with falsy values' => false,
    'key with html' => true,
    'key with classes' => true,
    'value with html' => true,
    'actions href' => true,
    'actions with html' => true,
    'actions with classes' => true,
    'actions with attributes' => true,
    'single action with anchor' => true,
    'classes on items' => true,
    'empty items array' => true,
    'rows with classes' => true,
    'summary card with custom classes' => true,
    'summary card with custom attributes' => true,
    'summary card with only 1 action' => true
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
