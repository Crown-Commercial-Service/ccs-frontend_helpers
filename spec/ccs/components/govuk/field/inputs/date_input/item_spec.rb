# frozen_string_literal: true

require 'ccs/components/govuk/field/inputs/date_input/item'

RSpec.describe CCS::Components::GovUK::Field::Inputs::DateInput::Item do
  include_context 'and I have a view context'

  let(:date_input_item_element) { Capybara::Node::Simple.new(result).find('div.govuk-date-input__item') }
  let(:date_input_item_input_element) { date_input_item_element.find('input') }
  let(:date_input_item_label_element) { date_input_item_element.find('label') }

  let(:result) { govuk_date_input_item.render }

  let(:attribute) { 'xenoblade_chronicles_3' }
  let(:input) { {} }
  let(:label) { {} }
  let(:options) { {} }

  let(:model) { TestModel.new }

  describe '.render' do
    let(:govuk_date_input_item) { described_class.new(attribute: attribute, name: name, input: input, label: label, context: view_context, **options) }

    let(:name) { 'day' }

    let(:default_html) do
      '
        <div class="govuk-date-input__item">
          <div class="govuk-form-group" id="xenoblade_chronicles_3_day-form-group">
            <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_day">
              Day
            </label>
            <input type="text" name="xenoblade_chronicles_3_day" id="xenoblade_chronicles_3_day" inputmode="numeric" class="govuk-input govuk-date-input__input">
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the date input' do
        expect(date_input_item_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_date_input_item) { described_class.new(attribute: attribute, name: name, context: view_context) }

      it 'correctly formats the HTML with the date input' do
        expect(date_input_item_element.to_html).to eq(default_html)
      end
    end

    context 'when the item has a value' do
      let(:input) { { value: '29' } }

      it 'has the correct value' do
        expect(date_input_item_input_element[:value]).to eq('29')
      end
    end

    context 'when the item has a custom ID' do
      let(:input) { { attributes: { id: 'my-custom-day-id' } } }

      it 'is overwrites the ID of the date input item' do
        expect(date_input_item_input_element[:id]).to eq('my-custom-day-id')
        expect(date_input_item_label_element[:for]).to eq('my-custom-day-id')
      end
    end

    context 'when the item has a custom name attribute' do
      let(:input) { { attributes: { name: 'my-custom-day-name' } } }

      it 'is overwrites the names of the date input item' do
        expect(date_input_item_input_element[:name]).to eq('my-custom-day-name')
      end
    end

    context 'when there are custom attributes' do
      let(:input) { { classes: 'govuk-input--width-2 my-custom-class', attributes: { inputmode: 'text', data: { test: 'test' } } } }

      it 'renders the input with the custom attributes' do
        expect(date_input_item_input_element[:class]).to eq 'govuk-input govuk-date-input__input govuk-input--width-2 my-custom-class'
        expect(date_input_item_input_element[:inputmode]).to eq 'text'
        expect(date_input_item_input_element[:'data-test']).to eq 'test'
      end
    end

    context 'and we have custom text for the label' do
      let(:label) { { text: 'The Day' } }

      it 'has the custom label text' do
        expect(date_input_item_label_element).to have_content('The Day')
      end
    end

    context 'when there is an error message' do
      let(:options) { { error_message: 'You must enter the date' } }

      it 'adds the error class to the item' do
        expect(date_input_item_input_element[:class]).to eq 'govuk-input govuk-date-input__input govuk-input--error'
      end
    end
  end

  describe '.render with model' do
    let(:govuk_date_input_item) { described_class.new(attribute: attribute, name: name, input: input, label: label, model: model, context: view_context, **options) }

    let(:name) { 'month' }

    let(:default_html) do
      '
        <div class="govuk-date-input__item">
          <div class="govuk-form-group" id="xenoblade_chronicles_3_month-form-group">
            <label class="govuk-label govuk-date-input__label" for="xenoblade_chronicles_3_month">
              Month
            </label>
            <input type="text" name="xenoblade_chronicles_3_month" id="xenoblade_chronicles_3_month" inputmode="numeric" class="govuk-input govuk-date-input__input">
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with date input in the form' do
        expect(date_input_item_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_date_input_item) { described_class.new(attribute: attribute, name: name, model: model, context: view_context) }

      it 'correctly formats the HTML with date input in the form' do
        expect(date_input_item_element.to_html).to eq(default_html)
      end
    end

    context 'when the item has a value' do
      before { model.xenoblade_chronicles_3_month = '07' }

      it 'has the correct value' do
        expect(date_input_item_input_element[:value]).to eq('07')
      end
    end

    context 'when the item has a custom ID' do
      let(:input) { { attributes: { id: 'my-custom-month-id' } } }

      it 'is overwrites the ID of the date input item' do
        expect(date_input_item_input_element[:id]).to eq('my-custom-month-id')
        expect(date_input_item_label_element[:for]).to eq('my-custom-month-id')
      end
    end

    context 'when the item has a custom name attribute' do
      let(:input) { { attributes: { name: 'my-custom-month-name' } } }

      it 'is overwrites the names of the date input item' do
        expect(date_input_item_input_element[:name]).to eq('my-custom-month-name')
      end
    end

    context 'when there are custom attributes' do
      let(:input) { { classes: 'govuk-input--width-2 my-custom-class', attributes: { inputmode: 'text', data: { test: 'test' } } } }

      it 'renders the input with the custom attributes' do
        expect(date_input_item_input_element[:class]).to eq 'govuk-input govuk-date-input__input govuk-input--width-2 my-custom-class'
        expect(date_input_item_input_element[:inputmode]).to eq 'text'
        expect(date_input_item_input_element[:'data-test']).to eq 'test'
      end
    end

    context 'and we have custom text for the label' do
      let(:label) { { text: 'The Month' } }

      it 'has the custom label text' do
        expect(date_input_item_label_element).to have_content('The Month')
      end
    end

    context 'when there is an error message on the parent attribute' do
      before { model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

      it 'does not add the error class to the item' do
        expect(date_input_item_input_element[:class]).to eq 'govuk-input govuk-date-input__input'
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_date_input_item) { described_class.new(attribute: attribute, name: name, input: input, label: label, form: form, context: view_context, **options) }

    let(:name) { 'year' }

    let(:default_html) do
      '
        <div class="govuk-date-input__item">
          <div class="govuk-form-group" id="xenoblade_chronicles_3_year-form-group">
            <label class="govuk-label govuk-date-input__label" for="test_model_xenoblade_chronicles_3_year">
              Year
            </label>
            <input inputmode="numeric" class="govuk-input govuk-date-input__input" type="text" name="test_model[xenoblade_chronicles_3_year]" id="test_model_xenoblade_chronicles_3_year">
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with date input in the form' do
        expect(date_input_item_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_date_input_item) { described_class.new(attribute: attribute, name: name, form: form, context: view_context) }

      it 'correctly formats the HTML with date input in the form' do
        expect(date_input_item_element.to_html).to eq(default_html)
      end
    end

    context 'when the item has a value' do
      before { model.xenoblade_chronicles_3_year = '2022' }

      it 'has the correct value' do
        expect(date_input_item_input_element[:value]).to eq('2022')
      end
    end

    context 'when the item has a custom ID' do
      let(:input) { { attributes: { id: 'my-custom-month-id' } } }

      it 'is overwrites the ID of the date input item' do
        expect(date_input_item_input_element[:id]).to eq('my-custom-month-id')
        expect(date_input_item_label_element[:for]).to eq('my-custom-month-id')
      end
    end

    context 'when the item has a custom name attribute' do
      let(:input) { { attributes: { name: 'my-custom-month-name' } } }

      it 'is overwrites the names of the date input item' do
        expect(date_input_item_input_element[:name]).to eq('my-custom-month-name')
      end
    end

    context 'when there are custom attributes' do
      let(:input) { { classes: 'govuk-input--width-2 my-custom-class', attributes: { inputmode: 'text', data: { test: 'test' } } } }

      it 'renders the input with the custom attributes' do
        expect(date_input_item_input_element[:class]).to eq 'govuk-input govuk-date-input__input govuk-input--width-2 my-custom-class'
        expect(date_input_item_input_element[:inputmode]).to eq 'text'
        expect(date_input_item_input_element[:'data-test']).to eq 'test'
      end
    end

    context 'and we have custom text for the label' do
      let(:label) { { text: 'The Month' } }

      it 'has the custom label text' do
        expect(date_input_item_label_element).to have_content('The Month')
      end
    end

    context 'when there is an error message on the parent attribute' do
      before { model.errors.add(:xenoblade_chronicles_3, 'You must enter the date') }

      it 'does not add the error class to the item' do
        expect(date_input_item_input_element[:class]).to eq 'govuk-input govuk-date-input__input'
      end
    end
  end
end
