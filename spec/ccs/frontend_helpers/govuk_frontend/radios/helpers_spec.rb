# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/radios'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Radios, '#helpers', type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:fieldset_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }
  let(:legend_element) { Capybara::Node::Simple.new(result).find('legend.govuk-fieldset__legend') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:radios_element) { Capybara::Node::Simple.new(result).find('div.govuk-radios') }
  let(:radio_item_elements) { radios_element.all('div.govuk-radios__item') }

  let(:attribute) { 'ouroboros' }
  let(:radio_items) do
    [
      {
        value: 'noah',
        label: {
          text: 'Noah'
        }
      },
      {
        value: 'mio',
        label: {
          text: 'Mio'
        }
      },
      {
        value: 'eunie',
        label: {
          text: 'Eunie'
        }
      },
      {
        value: 'taion',
        label: {
          text: 'Taion'
        }
      },
      {
        value: 'lanz',
        label: {
          text: 'Lanz'
        }
      },
      {
        value: 'sena',
        label: {
          text: 'Sena'
        }
      }
    ]
  end
  let(:single_radio_item) do
    [
      {
        value: 'eunie',
        label: {
          text: 'Eunie'
        }
      }
    ]
  end
  let(:conditional_radio_item) do
    [
      {
        value: 'eunie',
        label: {
          text: 'Eunie'
        },
        conditional: {
          content: 'Hello there!'
        }
      }
    ]
  end
  let(:options) do
    {
      form_group: {},
      fieldset: {
        legend: {
          text: 'Select your favourite character',
        }
      }
    }
  end
  let(:minimum_options) do
    {
      fieldset: {
        legend: {
          text: 'Select your favourite character'
        }
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: {},
      fieldset: {
        legend: {
          text: 'Select your favourite character',
        },
      },
      hint: {
        text: 'Pick one option from the list'
      }
    }
  end
  let(:test_model) { TestModel.new }

  describe '.govuk_radios' do
    let(:result) { govuk_radios(attribute, radio_items, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite character
            </legend>
            <div class="govuk-radios" data-module="govuk-radios">
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_noah" value="noah" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_mio" value="mio" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_taion" value="taion" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_lanz" value="lanz" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_sena" value="sena" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with radios in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_radios(attribute, radio_items, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with radios in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:radio_items) { single_radio_item }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <fieldset aria-describedby="ouroboros-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  Select your favourite character
                </legend>
                <div id="ouroboros-hint" class="govuk-hint">
                  Pick one option from the list
                </div>
                <div class="govuk-radios" data-module="govuk-radios">
                  <div class="govuk-radios__item">
                    <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input">
                    <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                      Eunie
                    </label>
                  </div>
                </div>
              </fieldset>
            </div>
          '.to_one_line)
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must choose your favourite character' }
      let(:radio_items) { single_radio_item }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite character
              </legend>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error:</span> You must choose your favourite character
              </p>
              <div class="govuk-radios" data-module="govuk-radios">
                <div class="govuk-radios__item">
                  <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input">
                  <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must choose your favourite character' }
      let(:options) { options_with_hint }
      let(:radio_items) { single_radio_item }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-hint ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite character
              </legend>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the list
              </div>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error:</span> You must choose your favourite character
              </p>
              <div class="govuk-radios" data-module="govuk-radios">
                <div class="govuk-radios__item">
                  <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input">
                  <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is conditional content within the item' do
      let(:radio_items) { conditional_radio_item }

      it 'correctly formats the HTML with the conditional item' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <fieldset class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite character
              </legend>
              <div class="govuk-radios" data-module="govuk-radios">
                <div class="govuk-radios__item">
                  <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input" data-aria-controls="conditional-ouroboros_eunie">
                  <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                </div>
                <div class="govuk-radios__conditional govuk-radios__conditional--hidden" id="conditional-ouroboros_eunie">
                  Hello there!
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_radios with model' do
    let(:result) { govuk_radios(attribute, radio_items, model: test_model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite character
            </legend>
            <div class="govuk-radios" data-module="govuk-radios">
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_noah" value="noah" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_mio" value="mio" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_taion" value="taion" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_lanz" value="lanz" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_sena" value="sena" class="govuk-radios__input">
                <label class="govuk-label govuk-radios__label" for="ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with radios in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_radios(attribute, radio_items, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with radios in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_radios with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_radios(attribute, radio_items, form: form, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite character
            </legend>
            <div class="govuk-radios" data-module="govuk-radios">
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" type="radio" value="noah" name="test_model[ouroboros]" id="test_model_ouroboros_noah">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" type="radio" value="mio" name="test_model[ouroboros]" id="test_model_ouroboros_mio">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" type="radio" value="taion" name="test_model[ouroboros]" id="test_model_ouroboros_taion">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" type="radio" value="lanz" name="test_model[ouroboros]" id="test_model_ouroboros_lanz">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" type="radio" value="sena" name="test_model[ouroboros]" id="test_model_ouroboros_sena">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with radios in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_radios(attribute, radio_items, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with radios in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end
end
