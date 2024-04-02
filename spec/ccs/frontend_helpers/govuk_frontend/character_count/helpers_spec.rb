# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/character_count'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::CharacterCount, '#helpers', type: :helper do
  include described_class

  let(:character_count_element) { Capybara::Node::Simple.new(result).find('div.govuk-character-count') }
  let(:textarea_element) { Capybara::Node::Simple.new(result).find('textarea.govuk-textarea') }
  let(:textarea_description_element) { Capybara::Node::Simple.new(result).find('div.govuk-character-count__message') }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: {},
      label: {
        text: 'Explain why they are your favourite character'
      },
    }
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Explain why they are your favourite character'
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: {},
      label: {
        text: 'Explain why they are your favourite character'
      },
      hint: {
        text: 'For example, is it their combat, or their style?'
      }
    }
  end
  let(:form_group_options) { {} }
  let(:character_count_options) { { maxlength: 200 } }
  let(:test_model) { TestModel.new }

  describe '.govuk_character_count' do
    let(:result) { govuk_character_count(attribute, character_count_options, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div data-module="govuk-character-count" data-maxlength="200" class="govuk-form-group govuk-character-count" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Explain why they are your favourite character
          </label>
          <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info" class="govuk-textarea govuk-js-character-count" rows="5">
          </textarea>
          <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
            You can enter up to 200 characters
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_character_count(attribute, character_count_options, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a textarea description' do
      let(:character_count_options) { super().merge({ textarea_description: { count_message: 'Enter no more than %<count>s characters' } }) }

      it 'uses the custom textarea description message' do
        expect(textarea_description_element).to have_content('Enter no more than 200 characters')
      end
    end

    context 'when considering the other options used for the text area' do
      context 'when there is a hint' do
        let(:options) { options_with_hint }

        context 'when the default attributes are sent' do
          it 'correctly formats the HTML with the hint' do
            expect(character_count_element.to_html).to eq('
              <div data-module="govuk-character-count" data-maxlength="200" class="govuk-form-group govuk-character-count" id="ouroboros-form-group">
                <label class="govuk-label" for="ouroboros">
                  Explain why they are your favourite character
                </label>
                <div id="ouroboros-hint" class="govuk-hint">
                  For example, is it their combat, or their style?
                </div>
                <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-hint" class="govuk-textarea govuk-js-character-count" rows="5">
                </textarea>
                <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                  You can enter up to 200 characters
                </div>
              </div>
            '.to_one_line)
          end
        end
      end

      context 'when there is an error message' do
        let(:error_message) { 'You must enter your favourite character' }

        it 'correctly formats the HTML with error message and classes' do
          expect(character_count_element.to_html).to eq('
            <div data-module="govuk-character-count" data-maxlength="200" class="govuk-form-group govuk-form-group--error govuk-character-count" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Explain why they are your favourite character
              </label>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
              </p>
              <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5">
              </textarea>
              <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is a hint and an error message' do
        let(:error_message) { 'You must enter your favourite character' }
        let(:options) { options_with_hint }

        it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
          expect(character_count_element.to_html).to eq('
            <div data-module="govuk-character-count" data-maxlength="200" class="govuk-form-group govuk-form-group--error govuk-character-count" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Explain why they are your favourite character
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                For example, is it their combat, or their style?
              </div>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
              </p>
              <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info ouroboros-hint ouroboros-error" class="govuk-textarea govuk-js-character-count govuk-textarea--error" rows="5">
              </textarea>
              <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
                You can enter up to 200 characters
              </div>
            </div>
          '.to_one_line)
        end
      end
    end
  end

  describe '.govuk_character_count with model' do
    let(:result) { govuk_character_count(attribute, character_count_options, model: test_model, **options) }

    let(:default_html) do
      '
        <div data-module="govuk-character-count" data-maxlength="200" class="govuk-form-group govuk-character-count" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Explain why they are your favourite character
          </label>
          <textarea name="ouroboros" id="ouroboros" aria-describedby="ouroboros-info" class="govuk-textarea govuk-js-character-count" rows="5">
          </textarea>
          <div id="ouroboros-info" class="govuk-hint govuk-character-count__message">
            You can enter up to 200 characters
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_character_count(attribute, character_count_options, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_character_count with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_character_count(attribute, character_count_options, form: form, **options) }

    let(:default_html) do
      '
        <div data-module="govuk-character-count" data-maxlength="200" class="govuk-form-group govuk-character-count" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Explain why they are your favourite character
          </label>
          <textarea aria-describedby="test_model_ouroboros-info" class="govuk-textarea govuk-js-character-count" rows="5" name="test_model[ouroboros]" id="test_model_ouroboros">
          </textarea>
          <div id="test_model_ouroboros-info" class="govuk-hint govuk-character-count__message">
            You can enter up to 200 characters
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with character count around the textarea form' do
        expect(character_count_element.to_html).to eq(default_html)
      end
    end
  end
end
