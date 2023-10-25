# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/input'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Input, type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:input_wrapper_element) { Capybara::Node::Simple.new(result).find('div.govuk-input__wrapper') }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: {},
      label: {
        text: 'Select your favourite character'
      }
    }.merge(input_options)
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Select your favourite character',
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: {},
      label: {
        text: 'Select your favourite character'
      },
      hint: {
        text: 'Pick one option from the drop down'
      }
    }
  end
  let(:input_options) { {} }
  let(:test_model) { TestModel.new }

  describe '.govuk_input' do
    let(:result) { govuk_input(attribute, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite character
          </label>
          <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_input(attribute, **options) }
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
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite character
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <input type="text" name="ouroboros" id="ouroboros" class="govuk-input" aria-describedby="ouroboros-hint">
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
              Select your favourite character
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error: </span>
              You must enter your favourite character
            </p>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input govuk-input--error" aria-describedby="ouroboros-error">
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
              Select your favourite character
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error: </span>
              You must enter your favourite character
            </p>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error">
          </div>
        '.to_one_line)
      end
    end

    context 'and it includes a prefix' do
      let(:input_options) { { prefix: { text: '£' } } }

      let(:prefix_element) { input_wrapper_element.find('div.govuk-input__prefix') }

      it 'correctly formats the input HTML with the prefix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
          </div>
        '.to_one_line)
      end
    end

    context 'and it includes a suffix' do
      let(:input_options) { { suffix: { text: 'per week' } } }

      let(:suffix_element) { input_wrapper_element.find('div.govuk-input__suffix') }

      it 'correctly formats the input HTML with the suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when it includes both a prefix and suffix' do
      let(:input_options) { { prefix: { text: '£' }, suffix: { text: 'per week' } } }

      it 'correctly formats the input HTML with the prefix and suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_input with model' do
    let(:result) { govuk_input(attribute, model: test_model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite character
          </label>
          <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_input(attribute, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_input with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_input(attribute, form: form, **options) }

    let(:defeat_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Select your favourite character
          </label>
          <input class="govuk-input" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_input(attribute, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end
  end
end
