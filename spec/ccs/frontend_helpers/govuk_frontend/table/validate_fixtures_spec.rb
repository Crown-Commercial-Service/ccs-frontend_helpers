# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Table, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'table with head' => true,
    'table with head and caption' => true,
    'with small text modifier for tables with a lot of data' => true,
    'classes' => true,
    'attributes' => true,
    'html as text' => true,
    'html' => true,
    'head with classes' => true,
    'head with rowspan and colspan' => true,
    'head with attributes' => true,
    'with firstCellIsHeader true' => true,
    'firstCellIsHeader with classes' => true,
    'firstCellIsHeader with html' => true,
    'firstCellIsHeader with html as text' => true,
    'firstCellIsHeader with rowspan and colspan' => true,
    'firstCellIsHeader with attributes' => true,
    'with falsy items' => false,
    'rows with classes' => true,
    'rows with rowspan and colspan' => true,
    'rows with attributes' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'table')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'table').each do |fixture|
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
