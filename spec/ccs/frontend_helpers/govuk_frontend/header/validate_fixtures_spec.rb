# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Header, '#validate_fixtures', type: :helper do
  component_name = 'header'
  fixture_list = {
    'default' => true,
    'with service name' => true,
    'with service name but no service url' => true,
    'with navigation' => true,
    'with custom navigation label' => true,
    'with custom menu button text' => true,
    'with custom menu button label' => true,
    'with service name and navigation' => true,
    'with large navigation' => true,
    'with product name' => true,
    'full width' => true,
    'full width with navigation' => true,
    'with full width border' => true,
    'navigation item with html' => true,
    'navigation item with text without link' => true,
    "with St. Edward's Crown" => true,
    'attributes' => true,
    'classes' => true,
    'custom homepage url' => true,
    'navigation item with attributes' => true,
    'navigation item with html as text' => true,
    'navigation item with html without link' => true,
    'with custom navigation label and custom menu button text' => true,
    'empty navigation array' => true,
    'rebrand' => true,
    'with service name and navigation and rebrand' => true,
    'with product name and rebrand' => true,
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
