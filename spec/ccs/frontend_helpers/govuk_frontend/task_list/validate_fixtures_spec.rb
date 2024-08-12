# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::TaskList, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'example with 3 states' => true,
    'example with hint text and additional states' => true,
    'example with all possible colours' => true,
    'example with very long single word tags' => true,
    'custom classes' => true,
    'custom attributes' => true,
    'custom id prefix' => true,
    'html passed as text' => true,
    'html' => true,
    'with empty values' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'task-list')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'task-list').each do |fixture|
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
