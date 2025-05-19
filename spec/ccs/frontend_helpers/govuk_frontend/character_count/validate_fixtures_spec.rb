# frozen_string_literal: true

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::CharacterCount, '#validate_fixtures', type: :helper do
  fixture_list = {
    'default' => true,
    'with custom textarea description' => true,
    'with hint' => true,
    'with error' => true,
    'with hint and error' => true,
    'with default value' => true,
    'with default value exceeding limit' => true,
    'with custom rows' => true,
    'with label as page heading' => true,
    'with word count' => true,
    'with threshold' => true,
    'with translations' => true,
    'classes' => true,
    'id' => true,
    'attributes' => true,
    'formGroup with classes' => true,
    'custom classes on countMessage' => true,
    'spellcheck enabled' => true,
    'spellcheck disabled' => true,
    'custom classes with error message' => true,
    'with id starting with number' => true,
    'with id with special characters' => true,
    'with textarea maxlength attribute' => true,
    'to configure in JavaScript' => true,
    'when neither maxlength nor maxwords are set' => true,
    'when neither maxlength/maxwords nor textarea description are set' => true
  }

  tested_fixtures = FixturesLoader.get_tested_fixtures(:govuk_frontend, 'character-count')

  FixturesLoader.get_fixture_names(:govuk_frontend, 'character-count').each do |fixture|
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
