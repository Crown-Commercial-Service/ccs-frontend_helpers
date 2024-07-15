# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::BackLink, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with custom text' => true,
    'with custom link' => true,
    'inverse' => true,
    'classes' => true,
    'html as text' => true,
    'html' => true,
    'attributes' => true,
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'back-link')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'back-link').each do |fixture|
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
