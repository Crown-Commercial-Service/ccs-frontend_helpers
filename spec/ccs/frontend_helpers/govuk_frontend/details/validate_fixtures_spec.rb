# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Details, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'expanded' => true,
    'with html' => true,
    'id' => true,
    'html as text' => true,
    'html' => true,
    'summary html as text' => true,
    'summary html' => true,
    'classes' => true,
    'attributes' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('details')

  FixturesLoader.get_fixture_names('details').each do |fixture|
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
