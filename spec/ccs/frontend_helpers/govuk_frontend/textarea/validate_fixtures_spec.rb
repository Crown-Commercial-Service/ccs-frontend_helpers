# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Textarea, '#validate_fixtures', type: :helper do
  component_name = 'textarea'
  fixture_list = {
    'default' => true,
    'with hint' => true,
    'with error message' => true,
    'with default value' => true,
    'with custom rows' => true,
    'with label as page heading' => true,
    'with optional form-group classes' => true,
    'with autocomplete attribute' => true,
    'with spellcheck enabled' => true,
    'with spellcheck disabled' => true,
    'classes' => true,
    'id' => true,
    'attributes' => true,
    'with describedBy' => true,
    'with hint and described by' => true,
    'with error message and described by' => true,
    'with hint and error message' => true,
    'with hint, error message and described by' => true
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
