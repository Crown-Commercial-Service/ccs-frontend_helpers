# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ExitThisPage, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'translated' => true,
    'testing' => true,
    'testing-html' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('exit-this-page')

  FixturesLoader.get_fixture_names('exit-this-page').each do |fixture|
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
