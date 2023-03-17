# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/checkboxes'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Checkboxes, type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }

  let(:attribute) { 'ouroboros' }
  let(:checkbox_items) do
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
  let(:single_checkbox_item) do
    [
      {
        value: 'eunie',
        label: {
          text: 'Eunie'
        }
      }
    ]
  end
  let(:conditional_checkbox_item) do
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
          text: 'Select your favourite characters',
        },
      }
    }
  end
  let(:minimum_options) do
    {
      fieldset: {
        legend: {
          text: 'Select your favourite characters'
        }
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: {},
      fieldset: {
        legend: {
          text: 'Select your favourite characters',
        },
      },
      hint: {
        text: 'Pick at least one option from the list'
      },
    }
  end

  let(:model) { TestModel.new }

  describe '.govuk_checkboxes' do
    let(:result) { govuk_checkboxes(attribute, checkbox_items, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite characters
            </legend>
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_noah" value="noah" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_mio" value="mio" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_taion" value="taion" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_lanz" value="lanz" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_sena" value="sena" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_checkboxes(attribute, checkbox_items, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <fieldset aria-describedby="ouroboros-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  Select your favourite characters
                </legend>
                <div id="ouroboros-hint" class="govuk-hint">
                  Pick at least one option from the list
                </div>
                <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                  <div class="govuk-checkboxes__item">
                    <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                    <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
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
      let(:error_message) { 'You must choose your favourite characters' }
      let(:checkbox_items) { single_checkbox_item }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
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
      let(:error_message) { 'You must choose your favourite characters' }
      let(:options) { options_with_hint }
      let(:checkbox_items) { single_checkbox_item }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-hint ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick at least one option from the list
              </div>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite characters
              </p>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
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
      let(:checkbox_items) { conditional_checkbox_item }

      it 'correctly formats the HTML with the conditional item' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <fieldset class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite characters
              </legend>
              <div class="govuk-checkboxes" data-module="govuk-checkboxes">
                <div class="govuk-checkboxes__item">
                  <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input" data-aria-controls="ouroboros_eunie_conditional">
                  <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                  <div class="govuk-checkboxes__conditional govuk-checkboxes__conditional--hidden" id="ouroboros_eunie_conditional">
                    Hello there!
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_checkboxes with model' do
    let(:result) { govuk_checkboxes(attribute, checkbox_items, model: model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite characters
            </legend>
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_noah" value="noah" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_mio" value="mio" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_eunie" value="eunie" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_taion" value="taion" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_lanz" value="lanz" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input type="checkbox" name="ouroboros[]" id="ouroboros_sena" value="sena" class="govuk-checkboxes__input">
                <label class="govuk-label govuk-checkboxes__label" for="ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_checkboxes(attribute, checkbox_items, model: model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_checkboxes with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_checkboxes(attribute, checkbox_items, form: form, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              Select your favourite characters
            </legend>
            <div class="govuk-checkboxes" data-module="govuk-checkboxes">
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="noah" name="test_model[ouroboros][]" id="test_model_ouroboros_noah">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_noah">
                  Noah
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="mio" name="test_model[ouroboros][]" id="test_model_ouroboros_mio">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_mio">
                  Mio
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="eunie" name="test_model[ouroboros][]" id="test_model_ouroboros_eunie">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_eunie">
                  Eunie
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="taion" name="test_model[ouroboros][]" id="test_model_ouroboros_taion">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_taion">
                  Taion
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="lanz" name="test_model[ouroboros][]" id="test_model_ouroboros_lanz">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_lanz">
                  Lanz
                </label>
              </div>
              <div class="govuk-checkboxes__item">
                <input class="govuk-checkboxes__input" type="checkbox" value="sena" name="test_model[ouroboros][]" id="test_model_ouroboros_sena">
                <label class="govuk-label govuk-checkboxes__label" for="test_model_ouroboros_sena">
                  Sena
                </label>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_checkboxes(attribute, checkbox_items, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with checkboxes in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end
end
