# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Panel, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'custom heading level' => true,
    'title html as text' => true,
    'title html' => true,
    'body html as text' => true,
    'body html' => true,
    'classes' => true,
    'attributes' => true,
    'title with no body text' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'panel')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'panel').each do |fixture|
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
