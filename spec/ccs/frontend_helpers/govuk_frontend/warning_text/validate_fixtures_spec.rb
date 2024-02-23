# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::WarningText, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'multiple lines' => true,
    'attributes' => true,
    'classes' => true,
    'html' => true,
    'html as text' => true,
    'icon fallback text only' => true,
    'no icon fallback text' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('warning-text')

  FixturesLoader.get_fixture_names('warning-text').each do |fixture|
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
