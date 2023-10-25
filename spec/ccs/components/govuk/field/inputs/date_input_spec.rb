# frozen_string_literal: true

require 'ccs/components/govuk/field/inputs/date_input'

RSpec.describe CCS::Components::GovUK::Field::Inputs::DateInput do
  include_context 'and I have a view context'

  let(:form_group_element) { Capybara::Node::Simple.new(result).first('div.govuk-form-group') }
  let(:fieldset_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }
  let(:legend_element) { Capybara::Node::Simple.new(result).find('legend.govuk-fieldset__legend') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:date_inputs_element) { Capybara::Node::Simple.new(result).find('div.govuk-date-input') }
  let(:date_input_elements) { date_inputs_element.all('div.govuk-date-input__item') }

  let(:result) { govuk_date_input.render }

  let(:attribute) { 'xenoblade_chronicles_3' }
  let(:options) do
    {
      form_group: form_group_options,
      fieldset: {
        legend: {
          text: 'When did you buy Xenoblade Chronicles 3?',
        }.merge(legend_options),
      }.merge(fieldset_options)
    }.merge(date_input_options)
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
      }.merge(hint_options)
    }.merge(date_input_options)
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
  let(:test_model) { TestModel.new }

  describe '.render' do
    let(:govuk_date_input) { described_class.new(attribute: attribute, error_message: error_message, context: view_context, **options) }

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
      let(:govuk_date_input) { described_class.new(attribute: attribute, context: view_context, **options) }

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

    context 'when useing custom date items' do
      let(:date_input_options) { { date_items: date_items } }
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

  describe '.render with model' do
    let(:govuk_date_input) { described_class.new(attribute: attribute, model: test_model, context: view_context, **options) }

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

    context 'when useing custom date items' do
      let(:date_input_options) { { date_items: date_items } }
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

      before { test_model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

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

      before { test_model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

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

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_date_input) { described_class.new(attribute: attribute, form: form, context: view_context, **options) }

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

    context 'when useing custom date items' do
      let(:date_input_options) { { date_items: date_items } }
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

      before { test_model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

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

      before { test_model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

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
