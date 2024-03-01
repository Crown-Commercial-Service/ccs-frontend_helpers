# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/textarea'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Textarea, '#helpers', type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:label_element) { Capybara::Node::Simple.new(result).find('label.govuk-label') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:textarea_element) { Capybara::Node::Simple.new(result).find('textarea.govuk-textarea') }

  let(:attribute) { 'ouroboros' }
  let(:error_message) { nil }
  let(:options) do
    {
      form_group: {},
      label: {
        text: 'Explain why they are your favourite character'
      }
    }
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Explain why they are your favourite character',
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
        text: 'For example, is it their combat, or their style?',
      }
    }
  end
  let(:form_group_options) { {} }
  let(:label_options) { {} }
  let(:hint_options) { {} }
  let(:textarea_options) { {} }
  let(:test_model) { TestModel.new }

  describe '.govuk_textarea' do
    let(:result) { govuk_textarea(attribute, error_message: error_message, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Explain why they are your favourite character
          </label>
          <textarea name="ouroboros" id="ouroboros" class="govuk-textarea" rows="5">
          </textarea>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with textarea in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_textarea(attribute, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with textarea in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Explain why they are your favourite character
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                For example, is it their combat, or their style?
              </div>
              <textarea name="ouroboros" id="ouroboros" class="govuk-textarea" aria-describedby="ouroboros-hint" rows="5">
              </textarea>
            </div>
          '.to_one_line)
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must enter your favourite character' }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Explain why they are your favourite character
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <textarea name="ouroboros" id="ouroboros" class="govuk-textarea govuk-textarea--error" aria-describedby="ouroboros-error" rows="5">
            </textarea>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must enter your favourite character' }
      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Explain why they are your favourite character
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              For example, is it their combat, or their style?
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <textarea name="ouroboros" id="ouroboros" class="govuk-textarea govuk-textarea--error" aria-describedby="ouroboros-hint ouroboros-error" rows="5">
            </textarea>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_textarea with model' do
    let(:result) { govuk_textarea(attribute, model: test_model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Explain why they are your favourite character
          </label>
          <textarea name="ouroboros" id="ouroboros" class="govuk-textarea" rows="5">
          </textarea>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with textarea in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_textarea(attribute, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with textarea in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_textarea with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_textarea(attribute, form: form, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Explain why they are your favourite character
          </label>
          <textarea class="govuk-textarea" rows="5" name="test_model[ouroboros]" id="test_model_ouroboros">
          </textarea>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with textarea in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_textarea(attribute, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with textarea in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end
end
