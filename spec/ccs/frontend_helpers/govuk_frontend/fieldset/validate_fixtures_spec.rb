# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Fieldset, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'styled as xl text' => true,
    'styled as large text' => true,
    'styled as medium text' => true,
    'styled as small text' => true,
    'as page heading xl' => true,
    'as page heading l' => true,
    'as page heading m' => true,
    'as page heading s' => true,
    'as page heading without class' => true,
    'html fieldset content' => true,
    'with describedBy' => true,
    'html as text' => true,
    'html' => true,
    'legend classes' => true,
    'classes' => true,
    'role' => true,
    'attributes' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('fieldset')

  FixturesLoader.get_fixture_names('fieldset').each do |fixture|
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
