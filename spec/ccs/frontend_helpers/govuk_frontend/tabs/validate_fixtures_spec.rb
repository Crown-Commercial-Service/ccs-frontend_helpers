# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tabs, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'tabs-with-anchor-in-panel' => true,
    'classes' => true,
    'id' => true,
    'title' => true,
    'attributes' => true,
    'item with attributes' => true,
    'panel with attributes' => true,
    'no item list' => true,
    'empty item list' => true,
    'with falsey values' => false,
    'idPrefix' => true,
    'html as text' => true,
    'html' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures('tabs')

  FixturesLoader.get_fixture_names('tabs').each do |fixture|
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
