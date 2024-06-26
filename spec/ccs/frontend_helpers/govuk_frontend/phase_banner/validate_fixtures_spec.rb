# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::PhaseBanner, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'classes' => true,
    'text' => true,
    'html as text' => true,
    'attributes' => true,
    'tag html' => true,
    'tag classes' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'phase-banner')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'phase-banner').each do |fixture|
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
