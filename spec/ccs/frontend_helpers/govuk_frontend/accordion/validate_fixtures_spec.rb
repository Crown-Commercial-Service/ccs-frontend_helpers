# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Accordion, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with additional descriptions' => true,
    'with long content and description' => true,
    'with one section open' => true,
    'with all sections already open' => true,
    'with focusable elements inside' => true,
    'with translations' => true,
    'classes' => true,
    'attributes' => true,
    'custom heading level' => true,
    'heading html' => true,
    'with falsey values' => false,
    'with remember expanded off' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('accordion')

  FixturesLoader.get_fixture_names('accordion').each do |fixture|
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
