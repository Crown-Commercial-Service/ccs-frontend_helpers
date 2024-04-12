# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/password_input'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::PasswordInput, '#helpers', type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: {},
      label: {
        text: 'Enter your password'
      }
    }.merge(input_options)
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Enter your password',
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: {},
      label: {
        text: 'Enter your password'
      },
      hint: {
        text: 'It should be super secret'
      }
    }
  end
  let(:input_options) { {} }
  let(:test_model) { TestModel.new }

  describe '.govuk_password_input' do
    let(:result) { govuk_password_input(attribute, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Enter your password
          </label>
          <div class="govuk-input__wrapper govuk-password-input__wrapper">
            <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
            <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
              Show
            </button>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_password_input(attribute, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Enter your password
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                It should be super secret
              </div>
              <div class="govuk-input__wrapper govuk-password-input__wrapper">
                <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" aria-describedby="ouroboros-hint">
                <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                  Show
                </button>
              </div>
            </div>
          '.to_one_line)
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must enter your favourite character' }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Enter your password
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-error">
              <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must enter your favourite character' }
      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div data-module="govuk-password-input" class="govuk-form-group govuk-form-group--error govuk-password-input" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Enter your password
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              It should be super secret
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <div class="govuk-input__wrapper govuk-password-input__wrapper">
              <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error">
              <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
                Show
              </button>
            </div>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_password_input with model' do
    let(:result) { govuk_password_input(attribute, model: test_model, **options) }

    let(:default_html) do
      '
        <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Enter your password
          </label>
          <div class="govuk-input__wrapper govuk-password-input__wrapper">
            <input type="password" name="ouroboros" id="ouroboros" spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input">
            <button name="button" type="button" aria-controls="ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
              Show
            </button>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_password_input(attribute, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_password_input with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_password_input(attribute, form: form, **options) }

    let(:defeat_html) do
      '
        <div data-module="govuk-password-input" class="govuk-form-group govuk-password-input" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Enter your password
          </label>
          <div class="govuk-input__wrapper govuk-password-input__wrapper">
          <input spellcheck="false" autocapitalize="none" autocomplete="current-password" class="govuk-input govuk-password-input__input govuk-js-password-input-input" type="password" name="test_model[ouroboros]" id="test_model_ouroboros">
            <button name="button" type="button" aria-controls="test_model_ouroboros" aria-label="Show password" hidden="hidden" class="govuk-button govuk-button--secondary govuk-password-input__toggle govuk-js-password-input-toggle" data-module="govuk-button">
              Show
            </button>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_password_input(attribute, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end
  end
end
