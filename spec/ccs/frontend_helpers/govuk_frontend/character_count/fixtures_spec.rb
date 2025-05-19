# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/character_count'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::CharacterCount, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_character_count from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'character-count' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom textarea description'" do
      let(:fixture_name) { 'with custom textarea description' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength], textarea_description: { count_message: fixture_options[:textareaDescriptionText] } }, label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint'" do
      let(:fixture_name) { 'with hint' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], hint: fixture_options[:hint]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error'" do
      let(:fixture_name) { 'with error' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html.gsub("#{fixture_options[:id]}-error", "#{fixture_options[:name]}-error").gsub('govuk-textarea--error govuk-js-character-count', 'govuk-js-character-count govuk-textarea--error'))
      end
    end

    context "when the fixture is 'with hint and error'" do
      let(:fixture_name) { 'with hint and error' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html.gsub("#{fixture_options[:id]}-error", "#{fixture_options[:name]}-error").gsub('govuk-textarea--error govuk-js-character-count', 'govuk-js-character-count govuk-textarea--error'))
      end
    end

    context "when the fixture is 'with default value'" do
      let(:fixture_name) { 'with default value' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], content: fixture_options[:value], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with default value exceeding limit'" do
      let(:fixture_name) { 'with default value exceeding limit' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text], content: fixture_options[:value], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html.gsub("#{fixture_options[:id]}-error", "#{fixture_options[:name]}-error").gsub('govuk-textarea--error govuk-js-character-count', 'govuk-js-character-count govuk-textarea--error'))
      end
    end

    context "when the fixture is 'with custom rows'" do
      let(:fixture_name) { 'with custom rows' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], rows: fixture_options[:rows], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with label as page heading'" do
      let(:fixture_name) { 'with label as page heading' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: { id: fixture_options[:id] }) }

      before do
        fixture_options[:label][:is_page_heading] = fixture_options[:label][:isPageHeading]
        fixture_options[:label].delete(:isPageHeading)
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with word count'" do
      let(:fixture_name) { 'with word count' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxwords: fixture_options[:maxwords] }, label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with threshold'" do
      let(:fixture_name) { 'with threshold' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength], threshold: fixture_options[:threshold] }, label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with translations'" do
      let(:fixture_name) { 'with translations' }
      let(:result) do
        govuk_character_count(
          fixture_options[:name],
          {
            maxlength: fixture_options[:maxlength],
            characters_under_limit: {
              other: fixture_options[:charactersUnderLimitText][:other],
              one: fixture_options[:charactersUnderLimitText][:one],
            },
            characters_at_limit_text: fixture_options[:charactersAtLimitText],
            characters_over_limit: {
              other: fixture_options[:charactersOverLimitText][:other],
              one: fixture_options[:charactersOverLimitText][:one],
            },
            words_under_limit: {
              other: fixture_options[:wordsUnderLimitText][:other],
              one: fixture_options[:wordsUnderLimitText][:one],
            },
            words_at_limit_text: fixture_options[:wordsAtLimitText],
            words_over_limit: {
              other: fixture_options[:wordsOverLimitText][:other],
              one: fixture_options[:wordsOverLimitText][:one],
            },
          },
          label: fixture_options[:label]
        )
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'formGroup with classes'" do
      let(:fixture_name) { 'formGroup with classes' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], form_group: fixture_options[:formGroup]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom classes on countMessage'" do
      let(:fixture_name) { 'custom classes on countMessage' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength], textarea_description: fixture_options[:countMessage] }, label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'spellcheck enabled'" do
      let(:fixture_name) { 'spellcheck enabled' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: { spellcheck: fixture_options[:spellcheck] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'spellcheck disabled'" do
      let(:fixture_name) { 'spellcheck disabled' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: { spellcheck: fixture_options[:spellcheck] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom classes with error message'" do
      let(:fixture_name) { 'custom classes with error message' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], classes: fixture_options[:classes], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html.gsub('govuk-textarea--error govuk-js-character-count app-character-count--custom-modifier', 'govuk-js-character-count app-character-count--custom-modifier govuk-textarea--error'))
      end
    end

    context "when the fixture is 'with id starting with number'" do
      let(:fixture_name) { 'with id starting with number' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with id with special characters'" do
      let(:fixture_name) { 'with id with special characters' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with textarea maxlength attribute'" do
      let(:fixture_name) { 'with textarea maxlength attribute' }
      let(:result) { govuk_character_count(fixture_options[:name], { maxlength: fixture_options[:maxlength] }, label: fixture_options[:label], attributes: { id: fixture_options[:id], maxlength: fixture_options[:maxlength] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'to configure in JavaScript'" do
      let(:fixture_name) { 'to configure in JavaScript' }
      let(:result) { govuk_character_count(fixture_options[:name], label: fixture_options[:label], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'when neither maxlength nor maxwords are set'" do
      let(:fixture_name) { 'when neither maxlength nor maxwords are set' }
      let(:result) { govuk_character_count(fixture_options[:name], { textarea_description: { count_message: fixture_options[:textareaDescriptionText] } }, label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'when neither maxlength/maxwords nor textarea description are set'" do
      let(:fixture_name) { 'when neither maxlength/maxwords nor textarea description are set' }
      let(:result) { govuk_character_count(fixture_options[:name], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
