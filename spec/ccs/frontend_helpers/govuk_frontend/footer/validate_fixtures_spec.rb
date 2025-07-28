# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Footer, '#validate_fixtures', type: :helper do
  component_name = 'footer'
  fixture_list = {
    'default' => true,
    'with custom HTML content licence and copyright notice' => true,
    'with custom text content licence and copyright notice' => true,
    'with meta' => true,
    'with custom meta' => true,
    'with meta links and meta content' => true,
    'with default width navigation (one column)' => true,
    'with default width navigation (two columns)' => true,
    'with navigation' => true,
    'Full GDS example' => true,
    'Three equal columns' => true,
    'attributes' => true,
    'classes' => true,
    'with container classes' => true,
    'with HTML passed as text content' => true,
    'with empty meta' => true,
    'with empty meta items' => true,
    'meta html as text' => true,
    'with meta html' => true,
    'with meta item attributes' => true,
    'with empty navigation' => true,
    'with navigation item attributes' => true,
    'rebrand' => true
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
