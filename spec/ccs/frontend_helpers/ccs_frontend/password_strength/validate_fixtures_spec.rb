# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::CCSFrontend::PasswordStrength, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with symbol test' => true,
    'with number test' => true,
    'with uppercase test' => true,
    'with lowercase test' => true,
    'with all the tests' => true,
    'with custom text for all the tests' => true,
    'attributes' => true,
    'classes' => true,
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:ccs_frontend, 'password-strength')

  FixturesLoader.get_fixture_names(:ccs_frontend, 'password-strength').each do |fixture|
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
