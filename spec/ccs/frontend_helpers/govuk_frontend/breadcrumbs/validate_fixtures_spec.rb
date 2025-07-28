# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Breadcrumbs, '#validate_fixtures', type: :helper do
  component_name = 'breadcrumbs'
  fixture_list = {
    'default' => true,
    'with one level' => true,
    'without the home section' => true,
    'with last breadcrumb as current page' => true,
    'with collapse on mobile' => true,
    'inverse' => true,
    'classes' => true,
    'attributes' => true,
    'item attributes' => true,
    'html as text' => true,
    'html' => true,
    'custom label' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, component_name)

  it 'has only the tested fixtures' do
    expect(fixture_list.keys.sort).to eq(FixturesLoader.get_fixture_names(:govuk_frontend, component_name).sort)
  end

  FixturesLoader.get_fixture_names(:govuk_frontend, component_name).each do |fixture|
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
