# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/select'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Select, type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:label_element) { Capybara::Node::Simple.new(result).find('label.govuk-label') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:select_element) { Capybara::Node::Simple.new(result).find('select.govuk-select') }
  let(:option_elements) { select_element.all('option') }

  let(:attribute) { 'ouroboros' }
  let(:select_items) do
    [
      {
        value: 'noah',
        text: 'Noah'
      },
      {
        value: 'mio',
        text: 'Mio'
      },
      {
        value: 'eunie',
        text: 'Eunie'
      },
      {
        value: 'taion',
        text: 'Taion'
      },
      {
        value: 'lanz',
        text: 'Lanz'
      },
      {
        value: 'sena',
        text: 'Sena'
      }
    ]
  end
  let(:error_message) { nil }
  let(:options) do
    {
      form_group: {},
      label: {
        text: 'Select your favourite characters'
      }
    }
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Select your favourite characters',
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: {},
      label: {
        text: 'Select your favourite characters'
      },
      hint: {
        text: 'Pick one option from the drop down'
      }
    }
  end

  let(:test_model) { TestModel.new }

  describe '.govuk_select' do
    let(:result) { govuk_select(attribute, select_items, error_message: error_message, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite characters
          </label>
          <select name="ouroboros" id="ouroboros" class="govuk-select">
            <option value="noah">Noah</option>
            <option value="mio">Mio</option>
            <option value="eunie">Eunie</option>
            <option value="taion">Taion</option>
            <option value="lanz">Lanz</option>
            <option value="sena">Sena</option>
          </select>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_select(attribute, select_items, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with select in the form' do
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
                Select your favourite characters
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <select name="ouroboros" id="ouroboros" class="govuk-select" aria-describedby="ouroboros-hint">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
            </div>
          '.to_one_line)
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must select your favourite character' }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error: </span>
              You must select your favourite character
            </p>
            <select name="ouroboros" id="ouroboros" class="govuk-select govuk-select--error" aria-describedby="ouroboros-error">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must select your favourite character' }
      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error: </span>
              You must select your favourite character
            </p>
            <select name="ouroboros" id="ouroboros" class="govuk-select govuk-select--error" aria-describedby="ouroboros-hint ouroboros-error">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_select with model' do
    let(:result) { govuk_select(attribute, select_items, model: test_model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite characters
          </label>
          <select name="ouroboros" id="ouroboros" class="govuk-select">
            <option value="noah">Noah</option>
            <option value="mio">Mio</option>
            <option value="eunie">Eunie</option>
            <option value="taion">Taion</option>
            <option value="lanz">Lanz</option>
            <option value="sena">Sena</option>
          </select>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_select(attribute, select_items, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_select with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_select(attribute, select_items, form: form, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Select your favourite characters
          </label>
          <select class="govuk-select" name="test_model[ouroboros]" id="test_model_ouroboros">
            <option value="noah">Noah</option>
            <option value="mio">Mio</option>
            <option value="eunie">Eunie</option>
            <option value="taion">Taion</option>
            <option value="lanz">Lanz</option>
            <option value="sena">Sena</option>
          </select>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_select(attribute, select_items, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end
end
