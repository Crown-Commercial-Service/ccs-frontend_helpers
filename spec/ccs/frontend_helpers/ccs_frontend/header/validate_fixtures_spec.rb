# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Header, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with service name' => true,
    'with authentication options' => true,
    'with both navigation' => true,
    'with only primary navigation' => true,
    'with only secondary navigation' => true,
    'with custom navigation label' => true,
    'with custom menu button label' => true,
    'with service name, authentication and navigation' => true,
    'with large navigation' => true,
    'full example from CCS website' => true,
    'full width' => true,
    'full width with navigation and service authentication' => true,
    'navigation item with html' => true,
    'navigation item with text without link' => true,
    'attributes' => true,
    'classes' => true,
    'custom homepage url' => true,
    'navigation item with attributes' => true,
    'navigation item with html as text' => true,
    'navigation item with html without link' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:ccs_frontend, 'header')

  FixturesLoader.get_fixture_names(:ccs_frontend, 'header').each do |fixture|
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
