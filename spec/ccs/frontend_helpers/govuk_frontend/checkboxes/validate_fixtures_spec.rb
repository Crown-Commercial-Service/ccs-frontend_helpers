# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Checkboxes, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with pre-checked values' => true,
    'with divider and None' => true,
    'with divider, None and conditional items' => true,
    'with id and name' => true,
    'with hints on items' => true,
    'with disabled item' => true,
    'with legend as a page heading' => true,
    'with a medium legend' => true,
    'without fieldset' => true,
    "with single option set 'aria-describedby' on input" => true,
    "with single option (and hint) set 'aria-describedby' on input" => true,
    'with fieldset and error message' => true,
    'with error message' => true,
    'with error message and hints on items' => true,
    'with very long option text' => true,
    'with conditional items' => true,
    'with conditional items with special characters' => true,
    'with conditional item checked' => true,
    'with optional form-group classes showing group error' => true,
    'small' => true,
    'small with long text' => true,
    'small with error' => true,
    'small with hint' => true,
    'small with disabled' => true,
    'small with conditional reveal' => true,
    'with idPrefix' => true,
    'with falsey values' => false,
    'classes' => true,
    'with fieldset describedBy' => true,
    'attributes' => true,
    'with checked item' => true,
    'items with attributes' => true,
    'empty conditional' => true,
    'with label classes' => true,
    'multiple hints' => true,
    'with error message and hint' => true,
    'with error, hint and fieldset describedBy' => true,
    'label with attributes' => true,
    'fieldset params' => true,
    'fieldset html params' => true,
    "with single option set 'aria-describedby' on input, and describedBy" => true,
    "with single option (and hint) set 'aria-describedby' on input, and describedBy" => true,
    'with error and idPrefix' => true,
    'with error message and fieldset describedBy' => true,
    'item checked overrides values' => false,
    'textarea in conditional' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'checkboxes')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'checkboxes').each do |fixture|
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
