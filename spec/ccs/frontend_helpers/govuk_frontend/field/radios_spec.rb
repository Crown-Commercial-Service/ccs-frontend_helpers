# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/field/radios'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Field::Radios, type: :helper do
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
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'Select your favourite character',
        }.merge(legend_options),
      }.merge(fieldset_options),
      radios: radios_options
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
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'Select your favourite character',
        },
      }.merge(fieldset_options),
      hint: {
        text: 'Pick one option from the list'
      }.merge(hint_options),
      radios: radios_options
    }
  end
  let(:form_group_options) { {} }
  let(:fieldset_options) { {} }
  let(:legend_options) { {} }
  let(:hint_options) { {} }
  let(:radios_options) { {} }
  let(:model) { TestModel.new }

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

    context 'when considering attributes in a radio item' do
      context 'and we consider the radio item input' do
        context 'and it has an irregular value' do
          let(:radio_items) do
            [
              {
                value: 'Zeke Von Gembu, Bringer of Chaos',
                label: {
                  text: 'Zeke'
                }
              }
            ]
          end

          it 'is able to format an ID' do
            expect(radio_item_elements[0].find('input')[:id]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
            expect(radio_item_elements[0].find('label')[:for]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
          end
        end

        context 'and it has a custom ID' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  id: 'my-custom-radio-item-id'
                }
              }
            ]
          end

          it 'is overwrites the ID of the radio item' do
            expect(radio_item_elements[0].find('input')[:id]).to eq('my-custom-radio-item-id')
            expect(radio_item_elements[0].find('label')[:for]).to eq('my-custom-radio-item-id')
          end
        end

        context 'and it has a custom name' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  name: 'my-custom-radio-item-name'
                }
              }
            ]
          end

          it 'overwrites the ID of the radio item' do
            expect(radio_item_elements[0].find('input')[:name]).to eq('my-custom-radio-item-name')
          end
        end
      end

      context 'and we consider the radio item label' do
        context 'and it has custom classes' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  classes: 'my-custom-label-class'
                }
              }
            ]
          end

          it 'adds to the class of the radio item label' do
            expect(radio_item_elements[0].find('label')[:class]).to eq('govuk-label govuk-radios__label my-custom-label-class')
          end
        end

        context 'when the radio item label has custom attributes' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  attributes: {
                    id: 'my-custom-label-id',
                    data: {
                      test: 'custom-data-attribute'
                    }
                  }
                }
              }
            ]
          end

          it 'has the custom attributes on the label' do
            expect(radio_item_elements[0].find('label')[:id]).to eq('my-custom-label-id')
            expect(radio_item_elements[0].find('label')[:'data-test']).to eq('custom-data-attribute')
          end
        end
      end

      context 'when the radio item has a hint' do
        let(:radio_items) do
          [
            {
              value: 'eunie',
              label: {
                text: 'Eunie'
              },
              hint: {
                text: 'Come on, who else?'
              }
            },
            {
              value: 'sena',
              label: {
                text: 'Sena'
              },
              hint: {
                text: "I'm the girl with the gall!"
              }
            }
          ]
        end

        it 'renders the radio items with the hint' do
          expect(radios_element.to_html).to eq('
            <div class="govuk-radios" data-module="govuk-radios">
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input" aria-describedby="ouroboros_eunie-item-hint">
                <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                  Eunie
                </label>
                <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-radios__hint">
                  Come on, who else?
                </div>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_sena" value="sena" class="govuk-radios__input" aria-describedby="ouroboros_sena-item-hint">
                <label class="govuk-label govuk-radios__label" for="ouroboros_sena">
                  Sena
                </label>
                <div id="ouroboros_sena-item-hint" class="govuk-hint govuk-radios__hint">
                  I\'m the girl with the gall!
                </div>
              </div>
            </div>
          '.to_one_line)
        end

        context 'and the hint has custom ID' do
          let(:radio_items) do
            [
              {
                value: 'eunie',
                label: {
                  text: 'Eunie'
                },
                hint: {
                  text: 'Come on, who else?',
                  attributes: {
                    id: 'custom-radio-item-hint-id'
                  }
                }
              }
            ]
          end

          it 'renders the radio items with the custom hint ID' do
            expect(radio_item_elements[0].find('input')[:'aria-describedby']).to eq('custom-radio-item-hint-id')
            expect(radio_item_elements[0].find('div.govuk-hint')[:id]).to eq('custom-radio-item-hint-id')
          end
        end
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
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite character
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
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite character
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
                  <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input" data-aria-controls="ouroboros_eunie_conditional">
                  <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                  <div class="govuk-radios__conditional govuk-radios__conditional--hidden" id="ouroboros_eunie_conditional">
                    Hello there!
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when the item is checked' do
        before { conditional_radio_item[0][:checked] = true }

        it 'does not hide the conditional content' do
          expect(radio_item_elements[0].find_by_id('ouroboros_eunie_conditional')[:class]).to eq('govuk-radios__conditional')
        end
      end

      context 'when a custom ID is passed' do
        before { conditional_radio_item[0][:conditional][:attributes] = { id: 'my-custom-conditional-id' } }

        it 'has the custom id' do
          expect(radio_item_elements[0].find('input')[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(radio_item_elements[0].find('div')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        before { conditional_radio_item[0][:attributes] = { data: { test: 'data-test' } } }

        it 'has the correct attributes' do
          expect(radio_item_elements[0].find('input')[:'data-test']).to eq('data-test')
          expect(radio_item_elements[0].find('input')[:'data-aria-controls']).to eq('ouroboros_eunie_conditional')
        end
      end
    end
  end

  describe '.govuk_radios with model' do
    let(:result) { govuk_radios(attribute, radio_items, model: model, **options) }

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
      let(:result) { govuk_radios(attribute, radio_items, model: model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with radios in the form' do
        expect(form_group_element.to_html).to eq(default_html)
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
      before { model.ouroboros = 'eunie' }

      it 'checks the right option' do
        expect(radio_item_elements.count { |element| element.find('input').checked? }).to eq 1
        expect(radio_item_elements[2].find('input')).to be_checked
      end
    end

    context 'when considering attributes in a radio item' do
      context 'and we consider the radio item input' do
        context 'and it has an irregular value' do
          let(:radio_items) do
            [
              {
                value: 'Zeke Von Gembu, Bringer of Chaos',
                label: {
                  text: 'Zeke'
                }
              }
            ]
          end

          it 'is able to format an ID' do
            expect(radio_item_elements[0].find('input')[:id]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
            expect(radio_item_elements[0].find('label')[:for]).to eq('ouroboros_Zeke_Von_Gembu__Bringer_of_Chaos')
          end
        end

        context 'and it has a custom ID' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  id: 'my-custom-radio-item-id'
                }
              }
            ]
          end

          it 'is overwrites the ID of the radio item' do
            expect(radio_item_elements[0].find('input')[:id]).to eq('my-custom-radio-item-id')
            expect(radio_item_elements[0].find('label')[:for]).to eq('my-custom-radio-item-id')
          end
        end

        context 'and it has a custom name' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  name: 'my-custom-radio-item-name'
                }
              }
            ]
          end

          it 'overwrites the ID of the radio item' do
            expect(radio_item_elements[0].find('input')[:name]).to eq('my-custom-radio-item-name')
          end
        end
      end

      context 'and we consider the radio item label' do
        context 'and it has custom classes' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  classes: 'my-custom-label-class'
                }
              }
            ]
          end

          it 'adds to the class of the radio item label' do
            expect(radio_item_elements[0].find('label')[:class]).to eq('govuk-label govuk-radios__label my-custom-label-class')
          end
        end

        context 'when the radio item label has custom attributes' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  attributes: {
                    id: 'my-custom-label-id',
                    data: {
                      test: 'custom-data-attribute'
                    }
                  }
                }
              }
            ]
          end

          it 'has the custom attributes on the label' do
            expect(radio_item_elements[0].find('label')[:id]).to eq('my-custom-label-id')
            expect(radio_item_elements[0].find('label')[:'data-test']).to eq('custom-data-attribute')
          end
        end
      end

      context 'when the radio item has a hint' do
        let(:radio_items) do
          [
            {
              value: 'eunie',
              label: {
                text: 'Eunie'
              },
              hint: {
                text: 'Come on, who else?'
              }
            },
            {
              value: 'sena',
              label: {
                text: 'Sena'
              },
              hint: {
                text: "I'm the girl with the gall!"
              }
            }
          ]
        end

        it 'renders the radio items with the hint' do
          expect(radios_element.to_html).to eq('
            <div class="govuk-radios" data-module="govuk-radios">
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input" aria-describedby="ouroboros_eunie-item-hint">
                <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                  Eunie
                </label>
                <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-radios__hint">
                  Come on, who else?
                </div>
              </div>
              <div class="govuk-radios__item">
                <input type="radio" name="ouroboros" id="ouroboros_sena" value="sena" class="govuk-radios__input" aria-describedby="ouroboros_sena-item-hint">
                <label class="govuk-label govuk-radios__label" for="ouroboros_sena">
                  Sena
                </label>
                <div id="ouroboros_sena-item-hint" class="govuk-hint govuk-radios__hint">
                  I\'m the girl with the gall!
                </div>
              </div>
            </div>
          '.to_one_line)
        end

        context 'and the hint has custom ID' do
          let(:radio_items) do
            [
              {
                value: 'eunie',
                label: {
                  text: 'Eunie'
                },
                hint: {
                  text: 'Come on, who else?',
                  attributes: {
                    id: 'custom-radio-item-hint-id'
                  }
                }
              }
            ]
          end

          it 'renders the radio items with the custom hint ID' do
            expect(radio_item_elements[0].find('input')[:'aria-describedby']).to eq('custom-radio-item-hint-id')
            expect(radio_item_elements[0].find('div.govuk-hint')[:id]).to eq('custom-radio-item-hint-id')
          end
        end
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

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite character
              </legend>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite character
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

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

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
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite character
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
                  <input type="radio" name="ouroboros" id="ouroboros_eunie" value="eunie" class="govuk-radios__input" data-aria-controls="ouroboros_eunie_conditional">
                  <label class="govuk-label govuk-radios__label" for="ouroboros_eunie">
                    Eunie
                  </label>
                  <div class="govuk-radios__conditional govuk-radios__conditional--hidden" id="ouroboros_eunie_conditional">
                    Hello there!
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when the item is checked' do
        before { model.ouroboros = 'eunie' }

        it 'does not hide the conditional content' do
          expect(radio_item_elements[0].find_by_id('ouroboros_eunie_conditional')[:class]).to eq('govuk-radios__conditional')
        end
      end

      context 'when a custom ID is passed' do
        before { conditional_radio_item[0][:conditional][:attributes] = { id: 'my-custom-conditional-id' } }

        it 'has the custom id' do
          expect(radio_item_elements[0].find('input')[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(radio_item_elements[0].find('div')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        before { conditional_radio_item[0][:attributes] = { data: { test: 'data-test' } } }

        it 'has the correct attributes' do
          expect(radio_item_elements[0].find('input')[:'data-test']).to eq('data-test')
          expect(radio_item_elements[0].find('input')[:'data-aria-controls']).to eq('ouroboros_eunie_conditional')
        end
      end
    end
  end

  describe '.govuk_radios with form' do
    let(:result) { govuk_radios(attribute, radio_items, form: form, **options) }
    let(:form) do
      ActionView::Helpers::FormBuilder.new(
        TestModel.model_name.singular,
        model,
        TestView.new(:lookup_context, [], :controller),
        {}
      )
    end

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
      before { model.ouroboros = 'eunie' }

      it 'checks the right option' do
        expect(radio_item_elements.count { |element| element.find('input').checked? }).to eq 1
        expect(radio_item_elements[2].find('input')).to be_checked
      end
    end

    context 'when considering attributes in a radio item' do
      context 'and we consider the radio item input' do
        context 'and it has an irregular value' do
          let(:radio_items) do
            [
              {
                value: 'Zeke Von Gembu, Bringer of Chaos',
                label: {
                  text: 'Zeke'
                }
              }
            ]
          end

          it 'is able to format an ID' do
            expect(radio_item_elements[0].find('input')[:id]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
            expect(radio_item_elements[0].find('label')[:for]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
          end
        end

        context 'and it has a custom ID' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  id: 'my-custom-radio-item-id'
                }
              }
            ]
          end

          it 'is ignores the custom id' do
            expect(radio_item_elements[0].find('input')[:id]).to eq('my-custom-radio-item-id')
            expect(radio_item_elements[0].find('label')[:for]).to eq('my-custom-radio-item-id')
          end
        end

        context 'and it has a custom name' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah'
                },
                attributes: {
                  name: 'my-custom-radio-item-name'
                }
              }
            ]
          end

          it 'overwrites the ID of the radio item' do
            expect(radio_item_elements[0].find('input')[:name]).to eq('my-custom-radio-item-name')
          end
        end
      end

      context 'and we consider the radio item label' do
        context 'and it has custom classes' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  classes: 'my-custom-label-class'
                }
              }
            ]
          end

          it 'adds to the class of the radio item label' do
            expect(radio_item_elements[0].find('label')[:class]).to eq('govuk-label govuk-radios__label my-custom-label-class')
          end
        end

        context 'when the radio item label has custom attributes' do
          let(:radio_items) do
            [
              {
                value: 'noah',
                label: {
                  text: 'Noah',
                  attributes: {
                    id: 'my-custom-label-id',
                    data: {
                      test: 'custom-data-attribute'
                    }
                  }
                }
              }
            ]
          end

          it 'has the custom attributes on the label' do
            expect(radio_item_elements[0].find('label')[:id]).to eq('my-custom-label-id')
            expect(radio_item_elements[0].find('label')[:'data-test']).to eq('custom-data-attribute')
          end
        end
      end

      context 'when the radio item has a hint' do
        let(:radio_items) do
          [
            {
              value: 'eunie',
              label: {
                text: 'Eunie'
              },
              hint: {
                text: 'Come on, who else?'
              }
            },
            {
              value: 'sena',
              label: {
                text: 'Sena'
              },
              hint: {
                text: "I'm the girl with the gall!"
              }
            }
          ]
        end

        it 'renders the radio items with the hint' do
          expect(radios_element.to_html).to eq('
            <div class="govuk-radios" data-module="govuk-radios">
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" aria-describedby="ouroboros_eunie-item-hint" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
                  Eunie
                </label>
                <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-radios__hint">
                  Come on, who else?
                </div>
              </div>
              <div class="govuk-radios__item">
                <input class="govuk-radios__input" aria-describedby="ouroboros_sena-item-hint" type="radio" value="sena" name="test_model[ouroboros]" id="test_model_ouroboros_sena">
                <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_sena">
                  Sena
                </label>
                <div id="ouroboros_sena-item-hint" class="govuk-hint govuk-radios__hint">
                  I\'m the girl with the gall!
                </div>
              </div>
            </div>
          '.to_one_line)
        end

        context 'and the hint has custom ID' do
          let(:radio_items) do
            [
              {
                value: 'eunie',
                label: {
                  text: 'Eunie'
                },
                hint: {
                  text: 'Come on, who else?',
                  attributes: {
                    id: 'custom-radio-item-hint-id'
                  }
                }
              }
            ]
          end

          it 'renders the radio items with the custom hint ID' do
            expect(radio_item_elements[0].find('input')[:'aria-describedby']).to eq('custom-radio-item-hint-id')
            expect(radio_item_elements[0].find('div.govuk-hint')[:id]).to eq('custom-radio-item-hint-id')
          end
        end
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

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <fieldset aria-describedby="ouroboros-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                Select your favourite character
              </legend>
              <p class="govuk-error-message" id="ouroboros-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite character
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

      before { model.errors.add(:ouroboros, message: 'You must choose your favourite character') }

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
                <span class="govuk-visually-hidden">Error: </span>
                You must choose your favourite character
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
                  <input class="govuk-radios__input" data-aria-controls="ouroboros_eunie_conditional" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
                  <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
                    Eunie
                  </label>
                  <div class="govuk-radios__conditional govuk-radios__conditional--hidden" id="ouroboros_eunie_conditional">
                    Hello there!
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when the item is checked' do
        before { model.ouroboros = 'eunie' }

        it 'does not hide the conditional content' do
          expect(radio_item_elements[0].find_by_id('ouroboros_eunie_conditional')[:class]).to eq('govuk-radios__conditional')
        end
      end

      context 'when a custom ID is passed' do
        before { conditional_radio_item[0][:conditional][:attributes] = { id: 'my-custom-conditional-id' } }

        it 'has the custom id' do
          expect(radio_item_elements[0].find('input')[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(radio_item_elements[0].find('div')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        before { conditional_radio_item[0][:attributes] = { data: { test: 'data-test' } } }

        it 'has the correct attributes' do
          expect(radio_item_elements[0].find('input')[:'data-test']).to eq('data-test')
          expect(radio_item_elements[0].find('input')[:'data-aria-controls']).to eq('ouroboros_eunie_conditional')
        end
      end
    end
  end
end
