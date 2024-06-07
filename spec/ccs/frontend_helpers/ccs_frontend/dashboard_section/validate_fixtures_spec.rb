# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::CCSFrontend::DashboardSection, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with title text' => true,
    'with one long panel' => true,
    'with dashboard width two-thirds' => true,
    'with a panel width two-thirds' => true,
    'with panel widths one-half' => true,
    'attributes' => true,
    'classes' => true,
    'panel item with attributes' => true,
    'panel item with classes' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:ccs_frontend, 'dashboard-section')

  FixturesLoader.get_fixture_names(:ccs_frontend, 'dashboard-section').each do |fixture|
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
