# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/field/date_input'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Field::DateInput, type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).first('div.govuk-form-group') }
  let(:fieldset_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }
  let(:legend_element) { Capybara::Node::Simple.new(result).find('legend.govuk-fieldset__legend') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:date_inputs_element) { Capybara::Node::Simple.new(result).find('div.govuk-date-input') }
  let(:date_input_elements) { date_inputs_element.all('div.govuk-date-input__item') }

  let(:attribute) { 'xenoblade_chronicles_3' }
  let(:options) do
    {
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'When did you buy Xenoblade Chronicles 3?',
        }.merge(legend_options),
      }.merge(fieldset_options),
      date_input: date_input_options
    }
  end
  let(:minimum_options) do
    {
      fieldset: {
        legend: {
          text: 'When did you buy Xenoblade Chronicles 3?',
        }
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'When did you buy Xenoblade Chronicles 3?',
        }.merge(legend_options),
      }.merge(fieldset_options),
      hint: {
        text: 'This is when the money went out of your account'
      }.merge(hint_options),
      date_input: date_input_options
    }
  end
  let(:form_group_options) { {} }
  let(:fieldset_options) { {} }
  let(:legend_options) { {} }
  let(:hint_options) { {} }
  let(:date_input_options) { {} }
  let(:single_date_item) do
    [
      {
        name: 'day',
        input: {
          classes: 'govuk-input--width-2'
        }
      }
    ]
  end
  let(:model) { TestModel.new }

  describe '.govuk_date_input' do
    let(:result) { govuk_date_input(attribute, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="xenoblade_chronicles_3-form-group">
          <fieldset role="group" class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              When did you buy Xenoblade Chronicles 3?
            </legend>
            <div class="govuk-date-input">
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                    Day
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_month-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_month">
                    Month
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_month" id="xenoblade_chronicles_3_month" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_year-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_year">
                    Year
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_year" id="xenoblade_chronicles_3_year" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-4">
                </div>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with date input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_date_input(attribute, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with date input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:date_input_options) { { classes: 'my-custom-date-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(date_inputs_element[:class]).to eq('govuk-date-input my-custom-date-input-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:date_input_options) { { attributes: { id: 'my-custom-date-input-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(date_inputs_element[:id]).to eq('my-custom-date-input-id')
      end
    end

    context 'when considering attributes in a date item' do
      let(:date_input_options) { { date_items: date_items } }

      context 'and we consider the date item input' do
        context 'and it has a value' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  value: '29',
                  classes: 'govuk-input--width-2'
                }
              },
              {
                name: 'month',
                input: {
                  value: '07',
                  classes: 'govuk-input--width-2'
                }
              },
              {
                name: 'year',
                input: {
                  value: '2022',
                  classes: 'govuk-input--width-4'
                }
              }
            ]
          end

          it 'has the correct value' do
            expect(date_input_elements[0].find('input')[:value]).to eq('29')
            expect(date_input_elements[1].find('input')[:value]).to eq('07')
            expect(date_input_elements[2].find('input')[:value]).to eq('2022')
          end
        end

        context 'and it has a custom IDs' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    id: 'my-custom-day-id'
                  }
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    id: 'my-custom-month-id'
                  }
                }
              },
              {
                name: 'year',
                input: {
                  classes: 'govuk-input--width-4',
                  attributes: {
                    id: 'my-custom-year-id'
                  }
                }
              }
            ]
          end

          # rubocop:disable RSpec/MultipleExpectations
          it 'is overwrites the ID of the date input item' do
            expect(date_input_elements[0].find('input')[:id]).to eq('my-custom-day-id')
            expect(date_input_elements[0].find('label')[:for]).to eq('my-custom-day-id')
            expect(date_input_elements[1].find('input')[:id]).to eq('my-custom-month-id')
            expect(date_input_elements[1].find('label')[:for]).to eq('my-custom-month-id')
            expect(date_input_elements[2].find('input')[:id]).to eq('my-custom-year-id')
            expect(date_input_elements[2].find('label')[:for]).to eq('my-custom-year-id')
          end
          # rubocop:enable RSpec/MultipleExpectations
        end

        context 'and it has a custom name attributes' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    name: 'my-custom-day-name'
                  }
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    name: 'my-custom-month-name'
                  }
                }
              },
              {
                name: 'year',
                input: {
                  classes: 'govuk-input--width-4',
                  attributes: {
                    name: 'my-custom-year-name'
                  }
                }
              }
            ]
          end

          it 'is overwrites the names of the date input item' do
            expect(date_input_elements[0].find('input')[:name]).to eq('my-custom-day-name')
            expect(date_input_elements[1].find('input')[:name]).to eq('my-custom-month-name')
            expect(date_input_elements[2].find('input')[:name]).to eq('my-custom-year-name')
          end
        end

        context 'and it has a custom names with less items' do
          let(:date_items) do
            [
              {
                name: 'key',
                input: {
                  classes: 'govuk-input--width-2'
                }
              },
              {
                name: 'value',
                input: {
                  classes: 'govuk-input--width-2'
                }
              }
            ]
          end

          it 'is overwrites the names of the date input item' do
            expect(date_input_elements[0].to_html).to eq('
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_key-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_key">
                    Key
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_key" id="xenoblade_chronicles_3_key" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
            '.to_one_line)
            expect(date_input_elements[1].to_html).to eq('
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_value-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_value">
                    Value
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_value" id="xenoblade_chronicles_3_value" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
            '.to_one_line)
          end
        end

        context 'when there are no input options' do
          let(:date_items) do
            [
              {
                name: 'day'
              }
            ]
          end

          it 'renders the input with the default classes' do
            expect(date_input_elements[0].find('input')[:class]).to eq('govuk-input govuk-date-input__input')
          end
        end

        context 'when there are custom attributes' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2 my-custom-class',
                  attributes: {
                    inputmode: 'text',
                    data: {
                      test: 'test'
                    }
                  }
                }
              }
            ]
          end

          it 'renders the input with the custom attributes' do
            date_input_element = date_input_elements[0].find('input')

            expect(date_input_element[:class]).to eq 'govuk-input govuk-date-input__input govuk-input--width-2 my-custom-class'
            expect(date_input_element[:inputmode]).to eq 'text'
            expect(date_input_element[:'data-test']).to eq 'test'
          end
        end
      end

      context 'and we consider the date item labels' do
        context 'when the custom label text is passed' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2'
                },
                label: {
                  text: 'The Day'
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2'
                },
                label: {
                  text: 'The Month'
                }
              },
              {
                name: 'year',
                input: {
                  value: '2022',
                  classes: 'govuk-input--width-4'
                },
                label: {
                  text: 'The Year'
                }
              }
            ]
          end

          it 'has the custom label text' do
            expect(date_input_elements[0].find('label')).to have_content('The Day')
            expect(date_input_elements[1].find('label')).to have_content('The Month')
            expect(date_input_elements[2].find('label')).to have_content('The Year')
          end
        end
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:date_input_options) { { date_items: single_date_item } }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="xenoblade_chronicles_3-form-group">
              <fieldset role="group" aria-describedby="xenoblade_chronicles_3-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  When did you buy Xenoblade Chronicles 3?
                </legend>
                <div id="xenoblade_chronicles_3-hint" class="govuk-hint">
                  This is when the money went out of your account
                </div>
                <div class="govuk-date-input">
                  <div class="govuk-date-input__item">
                    <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                      <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                        Day
                      </label>
                      <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                    </div>
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
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must enter the date' }
      let(:date_input_options) { { date_items: single_date_item } }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="xenoblade_chronicles_3-form-group">
            <fieldset role="group" aria-describedby="xenoblade_chronicles_3-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                When did you buy Xenoblade Chronicles 3?
              </legend>
              <p class="govuk-error-message" id="xenoblade_chronicles_3-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must enter the date
              </p>
              <div class="govuk-date-input">
                <div class="govuk-date-input__item">
                  <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                    <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                      Day
                    </label>
                    <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2 govuk-input--error">
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must enter the date' }
      let(:options) { options_with_hint }
      let(:date_input_options) { { date_items: single_date_item } }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="xenoblade_chronicles_3-form-group">
            <fieldset role="group" aria-describedby="xenoblade_chronicles_3-hint xenoblade_chronicles_3-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                When did you buy Xenoblade Chronicles 3?
              </legend>
              <div id="xenoblade_chronicles_3-hint" class="govuk-hint">
                This is when the money went out of your account
              </div>
              <p class="govuk-error-message" id="xenoblade_chronicles_3-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must enter the date
              </p>
              <div class="govuk-date-input">
                <div class="govuk-date-input__item">
                  <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                    <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                      Day
                    </label>
                    <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2 govuk-input--error">
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-hint xenoblade_chronicles_3-error')
        end
      end
    end
  end

  describe '.govuk_date_input with model' do
    let(:result) { govuk_date_input(attribute, model: model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="xenoblade_chronicles_3-form-group">
          <fieldset role="group" class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              When did you buy Xenoblade Chronicles 3?
            </legend>
            <div class="govuk-date-input">
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                    Day
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_month-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_month">
                    Month
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_month" id="xenoblade_chronicles_3_month" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_year-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_year">
                    Year
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_year" id="xenoblade_chronicles_3_year" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-4">
                </div>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with date input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_date_input(attribute, model: model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with date input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:date_input_options) { { classes: 'my-custom-date-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(date_inputs_element[:class]).to eq('govuk-date-input my-custom-date-input-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:date_input_options) { { attributes: { id: 'my-custom-date-input-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(date_inputs_element[:id]).to eq('my-custom-date-input-id')
      end
    end

    context 'when considering attributes in a date item' do
      let(:date_input_options) { { date_items: date_items } }

      context 'and we consider the date item input' do
        context 'and it has a value' do
          let(:date_input_options) { {} }

          before do
            model.xenoblade_chronicles_3_day = '29'
            model.xenoblade_chronicles_3_month = '07'
            model.xenoblade_chronicles_3_year = '2022'
          end

          it 'has the correct value' do
            expect(date_input_elements[0].find('input')[:value]).to eq('29')
            expect(date_input_elements[1].find('input')[:value]).to eq('07')
            expect(date_input_elements[2].find('input')[:value]).to eq('2022')
          end
        end

        context 'and it has a custom IDs' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    id: 'my-custom-day-id'
                  }
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    id: 'my-custom-month-id'
                  }
                }
              },
              {
                name: 'year',
                input: {
                  classes: 'govuk-input--width-4',
                  attributes: {
                    id: 'my-custom-year-id'
                  }
                }
              }
            ]
          end

          # rubocop:disable RSpec/MultipleExpectations
          it 'is overwrites the ID of the date input item' do
            expect(date_input_elements[0].find('input')[:id]).to eq('my-custom-day-id')
            expect(date_input_elements[0].find('label')[:for]).to eq('my-custom-day-id')
            expect(date_input_elements[1].find('input')[:id]).to eq('my-custom-month-id')
            expect(date_input_elements[1].find('label')[:for]).to eq('my-custom-month-id')
            expect(date_input_elements[2].find('input')[:id]).to eq('my-custom-year-id')
            expect(date_input_elements[2].find('label')[:for]).to eq('my-custom-year-id')
          end
          # rubocop:enable RSpec/MultipleExpectations
        end

        context 'and it has a custom name attributes' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    name: 'my-custom-day-name'
                  }
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    name: 'my-custom-month-name'
                  }
                }
              },
              {
                name: 'year',
                input: {
                  classes: 'govuk-input--width-4',
                  attributes: {
                    name: 'my-custom-year-name'
                  }
                }
              }
            ]
          end

          it 'is overwrites the names of the date input item' do
            expect(date_input_elements[0].find('input')[:name]).to eq('my-custom-day-name')
            expect(date_input_elements[1].find('input')[:name]).to eq('my-custom-month-name')
            expect(date_input_elements[2].find('input')[:name]).to eq('my-custom-year-name')
          end
        end

        context 'and it has a custom names with less items' do
          let(:date_items) do
            [
              {
                name: 'dd',
                input: {
                  classes: 'govuk-input--width-2'
                }
              },
              {
                name: 'mm',
                input: {
                  classes: 'govuk-input--width-2'
                }
              }
            ]
          end

          it 'is overwrites the names of the date input item' do
            expect(date_input_elements[0].to_html).to eq('
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_dd-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_dd">
                    Dd
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_dd" id="xenoblade_chronicles_3_dd" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
            '.to_one_line)
            expect(date_input_elements[1].to_html).to eq('
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_mm-form-group">
                  <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_mm">
                    Mm
                  </label>
                  <input type="text" name="xenoblade_chronicles_3_mm" id="xenoblade_chronicles_3_mm" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                </div>
              </div>
            '.to_one_line)
          end
        end

        context 'when there are no input options' do
          let(:date_items) do
            [
              {
                name: 'day'
              }
            ]
          end

          it 'renders the input with the default classes' do
            expect(date_input_elements[0].find('input')[:class]).to eq('govuk-input govuk-date-input__input')
          end
        end

        context 'when there are custom attributes' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2 my-custom-class',
                  attributes: {
                    inputmode: 'text',
                    data: {
                      test: 'test'
                    }
                  }
                }
              }
            ]
          end

          it 'renders the input with the custom attributes' do
            date_input_element = date_input_elements[0].find('input')

            expect(date_input_element[:class]).to eq 'govuk-input govuk-date-input__input govuk-input--width-2 my-custom-class'
            expect(date_input_element[:inputmode]).to eq 'text'
            expect(date_input_element[:'data-test']).to eq 'test'
          end
        end
      end

      context 'and we consider the date item labels' do
        context 'when the custom label text is passed' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2'
                },
                label: {
                  text: 'The Day'
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2'
                },
                label: {
                  text: 'The Month'
                }
              },
              {
                name: 'year',
                input: {
                  value: '2022',
                  classes: 'govuk-input--width-4'
                },
                label: {
                  text: 'The Year'
                }
              }
            ]
          end

          it 'has the custom label text' do
            expect(date_input_elements[0].find('label')).to have_content('The Day')
            expect(date_input_elements[1].find('label')).to have_content('The Month')
            expect(date_input_elements[2].find('label')).to have_content('The Year')
          end
        end
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:date_input_options) { { date_items: single_date_item } }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="xenoblade_chronicles_3-form-group">
              <fieldset role="group" aria-describedby="xenoblade_chronicles_3-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  When did you buy Xenoblade Chronicles 3?
                </legend>
                <div id="xenoblade_chronicles_3-hint" class="govuk-hint">
                  This is when the money went out of your account
                </div>
                <div class="govuk-date-input">
                  <div class="govuk-date-input__item">
                    <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                      <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                        Day
                      </label>
                      <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2">
                    </div>
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
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-hint')
        end
      end
    end

    context 'when there is an error message on the main attribute' do
      let(:date_input_options) { { date_items: single_date_item } }

      before { model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="xenoblade_chronicles_3-form-group">
            <fieldset role="group" aria-describedby="xenoblade_chronicles_3-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                When did you buy Xenoblade Chronicles 3?
              </legend>
              <p class="govuk-error-message" id="xenoblade_chronicles_3-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must enter the date
              </p>
              <div class="govuk-date-input">
                <div class="govuk-date-input__item">
                  <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                    <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                      Day
                    </label>
                    <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2 govuk-input--error">
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }
      let(:date_input_options) { { date_items: single_date_item } }

      before { model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="xenoblade_chronicles_3-form-group">
            <fieldset role="group" aria-describedby="xenoblade_chronicles_3-hint xenoblade_chronicles_3-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                When did you buy Xenoblade Chronicles 3?
              </legend>
              <div id="xenoblade_chronicles_3-hint" class="govuk-hint">
                This is when the money went out of your account
              </div>
              <p class="govuk-error-message" id="xenoblade_chronicles_3-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must enter the date
              </p>
              <div class="govuk-date-input">
                <div class="govuk-date-input__item">
                  <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                    <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
                      Day
                    </label>
                    <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2 govuk-input--error">
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-hint xenoblade_chronicles_3-error')
        end
      end
    end
  end

  describe '.govuk_date_input with form' do
    let(:result) { govuk_date_input(attribute, form: form, **options) }
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
        <div class="govuk-form-group" id="xenoblade_chronicles_3-form-group">
          <fieldset role="group" class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              When did you buy Xenoblade Chronicles 3?
            </legend>
            <div class="govuk-date-input">
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                  <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_day">
                    Day
                  </label>
                  <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2" type="text" name="test_model[xenoblade_chronicles_3_day]" id="test_model_xenoblade_chronicles_3_day">
                </div>
              </div>
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_month-form-group">
                  <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_month">
                    Month
                  </label>
                  <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2" type="text" name="test_model[xenoblade_chronicles_3_month]" id="test_model_xenoblade_chronicles_3_month">
                </div>
              </div>
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_year-form-group">
                  <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_year">
                    Year
                  </label>
                  <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-4" type="text" name="test_model[xenoblade_chronicles_3_year]" id="test_model_xenoblade_chronicles_3_year">
                </div>
              </div>
            </div>
          </fieldset>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with date input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_date_input(attribute, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with date input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    # rubocop:disable RSpec/MultipleExpectations
    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:fieldset_options) { { classes: 'my-custom-fieldset-class' } }
      let(:legend_options) { { classes: 'my-custom-legend-class' } }
      let(:date_input_options) { { classes: 'my-custom-date-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(fieldset_element[:class]).to eq('govuk-fieldset my-custom-fieldset-class')
        expect(legend_element[:class]).to eq('govuk-fieldset__legend my-custom-legend-class')
        expect(date_inputs_element[:class]).to eq('govuk-date-input my-custom-date-input-class')
      end
    end
    # rubocop:enable RSpec/MultipleExpectations

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:fieldset_options) { { attributes: { id: 'my-custom-fieldset-id' } } }
      let(:date_input_options) { { attributes: { id: 'my-custom-date-input-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(fieldset_element[:id]).to eq('my-custom-fieldset-id')
        expect(date_inputs_element[:id]).to eq('my-custom-date-input-id')
      end
    end

    context 'when considering attributes in a date item' do
      let(:date_input_options) { { date_items: date_items } }

      context 'and we consider the date item input' do
        context 'and it has a value' do
          let(:date_input_options) { {} }

          before do
            model.xenoblade_chronicles_3_day = '29'
            model.xenoblade_chronicles_3_month = '07'
            model.xenoblade_chronicles_3_year = '2022'
          end

          it 'has the correct value' do
            expect(date_input_elements[0].find('input')[:value]).to eq('29')
            expect(date_input_elements[1].find('input')[:value]).to eq('07')
            expect(date_input_elements[2].find('input')[:value]).to eq('2022')
          end
        end

        context 'and it has a custom IDs' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    id: 'my-custom-day-id'
                  }
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    id: 'my-custom-month-id'
                  }
                }
              },
              {
                name: 'year',
                input: {
                  classes: 'govuk-input--width-4',
                  attributes: {
                    id: 'my-custom-year-id'
                  }
                }
              }
            ]
          end

          # rubocop:disable RSpec/MultipleExpectations
          it 'is overwrites the ID of the date input item' do
            expect(date_input_elements[0].find('input')[:id]).to eq('my-custom-day-id')
            expect(date_input_elements[0].find('label')[:for]).to eq('my-custom-day-id')
            expect(date_input_elements[1].find('input')[:id]).to eq('my-custom-month-id')
            expect(date_input_elements[1].find('label')[:for]).to eq('my-custom-month-id')
            expect(date_input_elements[2].find('input')[:id]).to eq('my-custom-year-id')
            expect(date_input_elements[2].find('label')[:for]).to eq('my-custom-year-id')
          end
          # rubocop:enable RSpec/MultipleExpectations
        end

        context 'and it has a custom name attributes' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    name: 'my-custom-day-name'
                  }
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2',
                  attributes: {
                    name: 'my-custom-month-name'
                  }
                }
              },
              {
                name: 'year',
                input: {
                  classes: 'govuk-input--width-4',
                  attributes: {
                    name: 'my-custom-year-name'
                  }
                }
              }
            ]
          end

          it 'is overwrites the names of the date input item' do
            expect(date_input_elements[0].find('input')[:name]).to eq('my-custom-day-name')
            expect(date_input_elements[1].find('input')[:name]).to eq('my-custom-month-name')
            expect(date_input_elements[2].find('input')[:name]).to eq('my-custom-year-name')
          end
        end

        context 'and it has a custom names with less items' do
          let(:date_items) do
            [
              {
                name: 'dd',
                input: {
                  classes: 'govuk-input--width-2'
                }
              },
              {
                name: 'mm',
                input: {
                  classes: 'govuk-input--width-2'
                }
              }
            ]
          end

          it 'is overwrites the names of the date input item' do
            expect(date_input_elements[0].to_html).to eq('
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_dd-form-group">
                  <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_dd">
                    Dd
                  </label>
                  <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2" type="text" name="test_model[xenoblade_chronicles_3_dd]" id="test_model_xenoblade_chronicles_3_dd">
                </div>
              </div>
            '.to_one_line)
            expect(date_input_elements[1].to_html).to eq('
              <div class="govuk-date-input__item">
                <div class="govuk-form-group" id="xenoblade_chronicles_3_mm-form-group">
                  <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_mm">
                    Mm
                  </label>
                  <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2" type="text" name="test_model[xenoblade_chronicles_3_mm]" id="test_model_xenoblade_chronicles_3_mm">
                </div>
              </div>
            '.to_one_line)
          end
        end

        context 'when there are no input options' do
          let(:date_items) do
            [
              {
                name: 'day'
              }
            ]
          end

          it 'renders the input with the default classes' do
            expect(date_input_elements[0].find('input')[:class]).to eq('govuk-input govuk-date-input__input')
          end
        end

        context 'when there are custom attributes' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2 my-custom-class',
                  attributes: {
                    inputmode: 'text',
                    data: {
                      test: 'test'
                    }
                  }
                }
              }
            ]
          end

          it 'renders the input with the custom attributes' do
            date_input_element = date_input_elements[0].find('input')

            expect(date_input_element[:class]).to eq 'govuk-input govuk-date-input__input govuk-input--width-2 my-custom-class'
            expect(date_input_element[:inputmode]).to eq 'text'
            expect(date_input_element[:'data-test']).to eq 'test'
          end
        end
      end

      context 'and we consider the date item labels' do
        context 'when the custom label text is passed' do
          let(:date_items) do
            [
              {
                name: 'day',
                input: {
                  classes: 'govuk-input--width-2'
                },
                label: {
                  text: 'The Day'
                }
              },
              {
                name: 'month',
                input: {
                  classes: 'govuk-input--width-2'
                },
                label: {
                  text: 'The Month'
                }
              },
              {
                name: 'year',
                input: {
                  value: '2022',
                  classes: 'govuk-input--width-4'
                },
                label: {
                  text: 'The Year'
                }
              }
            ]
          end

          it 'has the custom label text' do
            expect(date_input_elements[0].find('label')).to have_content('The Day')
            expect(date_input_elements[1].find('label')).to have_content('The Month')
            expect(date_input_elements[2].find('label')).to have_content('The Year')
          end
        end
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }
      let(:date_input_options) { { date_items: single_date_item } }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="xenoblade_chronicles_3-form-group">
              <fieldset role="group" aria-describedby="xenoblade_chronicles_3-hint" class="govuk-fieldset">
                <legend class="govuk-fieldset__legend">
                  When did you buy Xenoblade Chronicles 3?
                </legend>
                <div id="xenoblade_chronicles_3-hint" class="govuk-hint">
                  This is when the money went out of your account
                </div>
                <div class="govuk-date-input">
                  <div class="govuk-date-input__item">
                    <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                      <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_day">
                        Day
                      </label>
                      <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2" type="text" name="test_model[xenoblade_chronicles_3_day]" id="test_model_xenoblade_chronicles_3_day">
                    </div>
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
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-hint')
        end
      end
    end

    context 'when there is an error message on the main attribute' do
      let(:date_input_options) { { date_items: single_date_item } }

      before { model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="xenoblade_chronicles_3-form-group">
            <fieldset role="group" aria-describedby="xenoblade_chronicles_3-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                When did you buy Xenoblade Chronicles 3?
              </legend>
              <p class="govuk-error-message" id="xenoblade_chronicles_3-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must enter the date
              </p>
              <div class="govuk-date-input">
                <div class="govuk-date-input__item">
                  <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                    <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_day">
                      Day
                    </label>
                    <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2 govuk-input--error" type="text" name="test_model[xenoblade_chronicles_3_day]" id="test_model_xenoblade_chronicles_3_day">
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }
      let(:date_input_options) { { date_items: single_date_item } }

      before { model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="xenoblade_chronicles_3-form-group">
            <fieldset role="group" aria-describedby="xenoblade_chronicles_3-hint xenoblade_chronicles_3-error" class="govuk-fieldset">
              <legend class="govuk-fieldset__legend">
                When did you buy Xenoblade Chronicles 3?
              </legend>
              <div id="xenoblade_chronicles_3-hint" class="govuk-hint">
                This is when the money went out of your account
              </div>
              <p class="govuk-error-message" id="xenoblade_chronicles_3-error">
                <span class="govuk-visually-hidden">Error: </span>
                You must enter the date
              </p>
              <div class="govuk-date-input">
                <div class="govuk-date-input__item">
                  <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
                    <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_day">
                      Day
                    </label>
                    <input inputmode="numeric" class="govuk-input govuk-date-input__input govuk-input--width-2 govuk-input--error" type="text" name="test_model[xenoblade_chronicles_3_day]" id="test_model_xenoblade_chronicles_3_day">
                  </div>
                </div>
              </div>
            </fieldset>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the fieldset is passed' do
        let(:fieldset_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the fieldset aria described by as the custom, hint and error id' do
          expect(fieldset_element[:'aria-describedby']).to eq('some-id xenoblade_chronicles_3-hint xenoblade_chronicles_3-error')
        end
      end
    end
  end
end
