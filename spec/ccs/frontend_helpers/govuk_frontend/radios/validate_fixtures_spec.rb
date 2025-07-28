# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Radios, '#validate_fixtures', type: :helper do
  component_name = 'radios'
  fixture_list = {
    'default' => true,
    'with hint' => true,
    'inline' => true,
    'with disabled' => true,
    'with legend as page heading' => true,
    'with a divider' => true,
    'with hints on items' => true,
    'without fieldset' => true,
    'with fieldset and error message' => true,
    'with very long option text' => true,
    'with conditional items' => true,
    'with conditional items with special characters' => true,
    'with conditional item checked' => true,
    'prechecked using value' => true,
    'with conditional items and pre-checked value' => true,
    'with optional form-group classes showing group error' => true,
    'small' => true,
    'small with long text' => true,
    'small with error' => true,
    'small with hint' => true,
    'small with conditional reveal' => true,
    'small inline' => true,
    'small with a divider' => true,
    'with idPrefix' => true,
    'minimal items and name' => true,
    'with falsy items' => false,
    'fieldset with describedBy' => true,
    'attributes' => true,
    'items with attributes' => true,
    'with empty conditional' => true,
    'label with classes' => true,
    'with hints on parent and items' => true,
    'with describedBy and hint' => true,
    'with error message' => true,
    'with error message and idPrefix' => true,
    'with hint and error message' => true,
    'with hint, error message and describedBy' => true,
    'label with attributes' => true,
    'fieldset params' => true,
    'fieldset with html' => true,
    'with fieldset, error message and describedBy' => true,
    'item checked overrides value' => false,
    'textarea in conditional' => true
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
