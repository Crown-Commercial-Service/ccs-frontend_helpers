# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ServiceNavigation, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with navigation with a current item' => true,
    'with navigation with an active item' => true,
    'with large navigation' => true,
    'with HTML navigation items' => true,
    'with non-link navigation items' => true,
    'with service name' => true,
    'with service link' => true,
    'with long service name' => true,
    'with service name and navigation' => true,
    'with no options set' => true,
    'attributes' => true,
    'classes' => true,
    'with custom aria-label' => true,
    'with custom navigation toggle text' => true,
    'with custom navigation toggle label' => true,
    'with identical navigation toggle text and label' => true,
    'with custom navigation label' => true,
    'with custom navigation toggle text and navigation label' => true,
    'with custom navigation classes' => true,
    'with custom navigation ID' => true,
    'with navigation having empty values' => true,
    'with navigation having only empty values' => true,
    'with navigation being an empty array' => true,
    'with slotted content' => false
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'service-navigation')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'service-navigation').each do |fixture|
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
