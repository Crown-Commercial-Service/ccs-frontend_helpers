# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Logo, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:ccs_frontend, 'logo')

  FixturesLoader.get_fixture_names(:ccs_frontend, 'logo').each do |fixture|
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
