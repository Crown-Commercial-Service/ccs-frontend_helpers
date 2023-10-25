# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/date_input'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::DateInput, type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).first('div.govuk-form-group') }

  let(:attribute) { 'xenoblade_chronicles_3' }
  let(:options) do
    {
      form_group: {},
      fieldset: {
        legend: {
          text: 'When did you buy Xenoblade Chronicles 3?',
        },
      }
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
      form_group: {},
      fieldset: {
        legend: {
          text: 'When did you buy Xenoblade Chronicles 3?',
        },
      },
      hint: {
        text: 'This is when the money went out of your account'
      }
    }.merge(date_input_options)
  end
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
    end
  end

  describe '.govuk_date_input with model' do
    let(:result) { govuk_date_input(attribute, model: test_model, **options) }

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
      let(:result) { govuk_date_input(attribute, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with date input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_date_input with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_date_input(attribute, form: form, **options) }

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
  end
end
