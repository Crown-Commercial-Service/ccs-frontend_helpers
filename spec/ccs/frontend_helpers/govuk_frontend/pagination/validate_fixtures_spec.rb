# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Pagination, '#validate_fixtures', type: :helper do
  component_name = 'pagination'
  fixture_list = {
    'default' => true,
    'with custom navigation landmark' => true,
    'with custom link and item text' => true,
    'with custom accessible labels on item links' => true,
    'with many pages' => true,
    'first page' => true,
    'last page' => true,
    'with prev and next only' => true,
    'with prev and next only and labels' => true,
    'with prev and next only and very long labels' => true,
    'with previous only' => true,
    'with next only' => true,
    'with custom classes' => true,
    'with custom attributes' => true
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
