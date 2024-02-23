# frozen_string_literal: true

require 'ccs/components/govuk/field/inputs/radios'

RSpec.describe CCS::Components::GovUK::Field::Inputs::Radios do
  include_context 'and I have a view context'

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:fieldset_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }
  let(:legend_element) { Capybara::Node::Simple.new(result).find('legend.govuk-fieldset__legend') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:radios_element) { Capybara::Node::Simple.new(result).find('div.govuk-radios') }
  let(:radio_item_elements) { radios_element.all('div.govuk-radios__item') }

  let(:result) { govuk_radios.render }

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
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'Select your favourite character',
        }.merge(legend_options),
      }.merge(fieldset_options)
    }.merge(radios_options)
  end
  let(:options_with_hint) do
    {
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'Select your favourite character',
        },
      }.merge(fieldset_options),
      hint: {
        text: 'Pick one option from the list'
      }.merge(hint_options)
    }.merge(radios_options)
  end
  let(:form_group_options) { {} }
  let(:fieldset_options) { {} }
  let(:legend_options) { {} }
  let(:hint_options) { {} }
  let(:radios_options) { {} }
  let(:test_model) { TestModel.new }

  describe '.render' do
    let(:govuk_radios) { described_class.new(attribute: attribute, radio_items: radio_items, error_message: error_message, context: view_context, **options) }

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
      let(:govuk_radios) { described_class.new(attribute: attribute, radio_items: radio_items, context: view_context, **options) }

      let(:options) { {} }

      it 'correctly formats the HTML with radios in the form without the fieldset' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
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
          </div>
        '.to_one_line)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:radios_options) { { classes: 'my-custom-radios-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(radios_element[:class]).to eq('govuk-radios my-custom-radios-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:radios_options) { { attributes: { id: 'my-custom-radios-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(radios_element[:id]).to eq('my-custom-radios-id')
      end
    end

    context 'when one of the items is checked' do
      let(:radio_items) do
        [
          {
            value: 'noah',
            label: {
              text: 'Noah'
            }
          },
          {
            value: 'eunie',
            label: {
              text: 'Eunie'
            },
            checked: true
          },
          {
            value: 'lanz',
            label: {
              text: 'Lanz'
            }
          }
        ]
      end

      it 'checks the right option' do
        expect(radio_item_elements[0].find('input')).not_to be_checked
        expect(radio_item_elements[1].find('input')).to be_checked
        expect(radio_item_elements[2].find('input')).not_to be_checked
      end
    end

    context 'when there is a divider' do
      let(:radio_items) do
        [
          {
            value: 'noah',
            label: {
              text: 'Noah'
            }
          },
          {
            value: 'lanz',
            label: {
              text: 'Lanz'
            }
          },
          {
            divider: 'or'
          },
          {
            value: 'eunie',
            label: {
              text: 'Eunie'
            }
          }
        ]
      end

      it 'renders the radio divider amongst the items' do
        expect(radios_element.to_html).to eq('
          <div class="govuk-radios" data-module="govuk-radios">
            <div class="govuk-radios__item">
              <input type="radio" name="ouroboros" id="ouroboros_noah" value="noah" class="govuk-radios__input">
              <label class="govuk-label govuk-radios__label" for="ouroboros_noah">
                Noah
              </label>
            </div>
            <div class="govuk-radios__item">
              <input type="radio" name="ouroboros" id="ouroboros_lanz" value="lanz" class="govuk-radios__input">
              <label class="govuk-label govuk-radios__label" for="ouroboros_lanz">
                Lanz
              </label>
            </div>
            <div class="govuk-radios__divider">
              or
            </div>
            <div class="govuk-radios__item">
              <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input">
              <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                Eunie
              </label>
            </div>
          </div>
        '.to_one_line)
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

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the fieldset has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(fieldset_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and hint id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
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

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
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

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end
  end

  describe '.render with model' do
    let(:govuk_radios) { described_class.new(attribute: attribute, radio_items: radio_items, model: test_model, context: view_context, **options) }

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
      let(:options) { {} }

      it 'correctly formats the HTML with radios in the form without the fieldset' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
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
          </div>
        '.to_one_line)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:radios_options) { { classes: 'my-custom-radios-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(radios_element[:class]).to eq('govuk-radios my-custom-radios-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:radios_options) { { attributes: { id: 'my-custom-radios-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(radios_element[:id]).to eq('my-custom-radios-id')
      end
    end

    context 'when one of the items is checked' do
      before { test_model.ouroboros = 'eunie' }

      it 'checks the right option' do
        expect(radio_item_elements.count { |element| element.find('input').checked? }).to eq 1
        expect(radio_item_elements[2].find('input')).to be_checked
      end
    end

    context 'when one of the items is checked and the options are booleans' do
      let(:radio_items) do
        [
          {
            value: true,
            label: {
              text: 'Noah'
            }
          },
          {
            value: false,
            label: {
              text: 'N'
            }
          }
        ]
      end

      before { test_model.ouroboros = true }

      it 'checks the right option' do
        expect(radio_item_elements.count { |element| element.find('input').checked? }).to eq 1
        expect(radio_item_elements[0].find('input')).to be_checked
      end
    end

    context 'when there is a divider' do
      let(:radio_items) do
        [
          {
            value: 'noah',
            label: {
              text: 'Noah'
            }
          },
          {
            value: 'lanz',
            label: {
              text: 'Lanz'
            }
          },
          {
            divider: 'or'
          },
          {
            value: 'eunie',
            label: {
              text: 'Eunie'
            }
          }
        ]
      end

      it 'renders the radio divider amongst the items' do
        expect(radios_element.to_html).to eq('
          <div class="govuk-radios" data-module="govuk-radios">
            <div class="govuk-radios__item">
              <input type="radio" name="ouroboros" id="ouroboros_noah" value="noah" class="govuk-radios__input">
              <label class="govuk-label govuk-radios__label" for="ouroboros_noah">
                Noah
              </label>
            </div>
            <div class="govuk-radios__item">
              <input type="radio" name="ouroboros" id="ouroboros_lanz" value="lanz" class="govuk-radios__input">
              <label class="govuk-label govuk-radios__label" for="ouroboros_lanz">
                Lanz
              </label>
            </div>
            <div class="govuk-radios__divider">
              or
            </div>
            <div class="govuk-radios__item">
              <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input">
              <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                Eunie
              </label>
            </div>
          </div>
        '.to_one_line)
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

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the fieldset has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(fieldset_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and hint id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:radio_items) { single_radio_item }

      before { test_model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

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

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }
      let(:radio_items) { single_radio_item }

      before { test_model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

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

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_radios) { described_class.new(attribute: attribute, radio_items: radio_items, form: form, context: view_context, **options) }

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
      let(:options) { {} }

      it 'correctly formats the HTML with radios in the form without the fieldset' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
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
          </div>
        '.to_one_line)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:radios_options) { { classes: 'my-custom-radios-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(radios_element[:class]).to eq('govuk-radios my-custom-radios-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:radios_options) { { attributes: { id: 'my-custom-radios-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(radios_element[:id]).to eq('my-custom-radios-id')
      end
    end

    context 'when one of the items is checked' do
      before { test_model.ouroboros = 'eunie' }

      it 'checks the right option' do
        expect(radio_item_elements.count { |element| element.find('input').checked? }).to eq 1
        expect(radio_item_elements[2].find('input')).to be_checked
      end
    end

    context 'when one of the items is checked and the options are booleans' do
      let(:radio_items) do
        [
          {
            value: true,
            label: {
              text: 'Noah'
            }
          },
          {
            value: false,
            label: {
              text: 'N'
            }
          }
        ]
      end

      before { test_model.ouroboros = true }

      it 'checks the right option' do
        expect(radio_item_elements.count { |element| element.find('input').checked? }).to eq 1
        expect(radio_item_elements[0].find('input')).to be_checked
      end
    end

    context 'when there is a divider' do
      let(:radio_items) do
        [
          {
            value: 'mio',
            label: {
              text: 'Mio'
            }
          },
          {
            value: 'taion',
            label: {
              text: 'Taion'
            }
          },
          {
            divider: 'or'
          },
          {
            value: 'sena',
            label: {
              text: 'Sena'
            }
          }
        ]
      end

      it 'renders the radio divider amongst the items' do
        expect(radios_element.to_html).to eq('
          <div class="govuk-radios" data-module="govuk-radios">
            <div class="govuk-radios__item">
              <input class="govuk-radios__input" type="radio" value="mio" name="test_model[ouroboros]" id="test_model_ouroboros_mio">
              <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_mio">
                Mio
              </label>
            </div>
            <div class="govuk-radios__item">
              <input class="govuk-radios__input" type="radio" value="taion" name="test_model[ouroboros]" id="test_model_ouroboros_taion">
              <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_taion">
                Taion
              </label>
            </div>
            <div class="govuk-radios__divider">
              or
            </div>
            <div class="govuk-radios__item">
              <input class="govuk-radios__input" type="radio" value="sena" name="test_model[ouroboros]" id="test_model_ouroboros_sena">
              <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_sena">
                Sena
              </label>
            </div>
          </div>
        '.to_one_line)
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
                    <input class="govuk-radios__input" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
                    <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
                      Eunie
                    </label>
                  </div>
                </div>
              </fieldset>
            </div>
          '.to_one_line)
        end
      end

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the fieldset has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(fieldset_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and hint id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:radio_items) { single_radio_item }

      before { test_model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

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
                  <input class="govuk-radios__input" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
                  <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }
      let(:radio_items) { single_radio_item }

      before { test_model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

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
                  <input class="govuk-radios__input" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
                  <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
                    Eunie
                  </label>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end
  end
end
