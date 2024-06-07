# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tag, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'grey' => true,
    'blue' => true,
    'light blue' => true,
    'turquoise' => true,
    'green' => true,
    'purple' => true,
    'pink' => true,
    'red' => true,
    'orange' => true,
    'yellow' => true,
    'attributes' => true,
    'html as text' => true,
    'html' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'tag')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'tag').each do |fixture|
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
