# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ErrorMessage, '#validate_fixtures', type: :helper do
  component_name = 'error-message'
  fixture_list = {
    'default' => true,
    'translated' => true,
    'id' => true,
    'classes' => true,
    'html as text' => true,
    'html' => true,
    'attributes' => true,
    'with visually hidden text' => true,
    'visually hidden text removed' => true
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
