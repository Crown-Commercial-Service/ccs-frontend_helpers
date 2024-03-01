# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Hint, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with html' => true,
    'classes' => true,
    'id' => true,
    'html as text' => true,
    'attributes' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('hint')

  FixturesLoader.get_fixture_names('hint').each do |fixture|
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
