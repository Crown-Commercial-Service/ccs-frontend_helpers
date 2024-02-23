# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::CookieBanner, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'accepted confirmation banner' => true,
    'rejected confirmation banner' => true,
    'client-side implementation' => true,
    'with html' => true,
    'heading html' => true,
    'heading html as text' => true,
    'html' => true,
    'classes' => true,
    'attributes' => true,
    'custom aria label' => true,
    'hidden' => true,
    'hidden false' => true,
    'default action' => true,
    'link' => true,
    'link with false button options' => true,
    'link as a button' => true,
    'type' => true,
    'button classes' => true,
    'button attributes' => true,
    'link classes' => true,
    'link attributes' => true,
    'full banner hidden' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('cookie-banner')

  FixturesLoader.get_fixture_names('cookie-banner').each do |fixture|
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
