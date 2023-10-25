# frozen_string_literal: true

require 'ccs/components/govuk/field/inputs/item/radio/form'

RSpec.describe CCS::Components::GovUK::Field::Inputs::Item::Radio::Form do
  include_context 'and I have a view context'

  let(:radio_item_element) { Capybara::Node::Simple.new(result).find('div.govuk-radios__item') }
  let(:radio_item_input_element) { radio_item_element.find('input') }
  let(:radio_item_label_element) { radio_item_element.find('label') }

  describe '.render' do
    include_context 'and I have a form from a model'

    let(:govuk_radio_item) { described_class.new(attribute: attribute, value: value, label: label, hint: hint, conditional: conditional, form: form, context: view_context, **options) }
    let(:result) { govuk_radio_item.render }

    let(:attribute) { 'ouroboros' }
    let(:value) { 'eunie' }
    let(:label) { { text: 'Eunie' } }
    let(:hint) { nil }
    let(:conditional) { nil }
    let(:options) { {} }

    let(:test_model) { TestModel.new }

    let(:default_html) do
      '
        <div class="govuk-radios__item">
          <input class="govuk-radios__input" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
          <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
            Eunie
          </label>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the radio item' do
        expect(radio_item_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_radio_item) { described_class.new(attribute: attribute, value: value, label: label, form: form, context: view_context, **options) }

      it 'correctly formats the HTML for the radio item' do
        expect(radio_item_element.to_html).to eq(default_html)
      end
    end

    context 'when the item is checked' do
      before { test_model.ouroboros = 'eunie' }

      it 'checks the checbox' do
        expect(radio_item_input_element).to be_checked
      end
    end

    context 'when the value us an iregular value' do
      let(:value) { 'Zeke Von Gembu, Bringer of Chaos' }

      it 'is able to format an ID' do
        expect(radio_item_input_element[:id]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
        expect(radio_item_label_element[:for]).to eq('test_model_ouroboros_zeke_von_gembu_bringer_of_chaos')
      end
    end

    context 'and it has a custom ID' do
      let(:options) { { attributes: { id: 'my-custom-radio-item-id' } } }

      it 'is overwrites the ID of the radio item' do
        expect(radio_item_input_element[:id]).to eq('my-custom-radio-item-id')
        expect(radio_item_label_element[:for]).to eq('my-custom-radio-item-id')
      end
    end

    context 'and it has a custom name' do
      let(:options) { { attributes: { name: 'my-custom-radio-item-name' } } }

      it 'overwrites the ID of the radio item' do
        expect(radio_item_input_element[:name]).to eq('my-custom-radio-item-name')
      end
    end

    context 'and we consider the radio item label' do
      context 'and it has custom classes' do
        let(:label) do
          {
            text: 'Noah',
            classes: 'my-custom-label-class'
          }
        end

        it 'adds to the class of the radio item label' do
          expect(radio_item_label_element[:class]).to eq('govuk-label govuk-radios__label my-custom-label-class')
        end
      end

      context 'when the radio item label has custom attributes' do
        let(:label) do
          {
            text: 'Noah',
            attributes: {
              id: 'my-custom-label-id',
              data: {
                test: 'custom-data-attribute'
              }
            }
          }
        end

        it 'has the custom attributes on the label' do
          expect(radio_item_label_element[:id]).to eq('my-custom-label-id')
          expect(radio_item_label_element[:'data-test']).to eq('custom-data-attribute')
        end
      end
    end

    context 'when the radio item has a hint' do
      let(:hint) do
        {
          text: 'Come on, who else?'
        }.merge(hint_options)
      end
      let(:hint_options) { {} }

      it 'renders the radio item with the hint' do
        expect(radio_item_element.to_html).to eq('
          <div class="govuk-radios__item">
            <input class="govuk-radios__input" aria-describedby="ouroboros_eunie-item-hint" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
            <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
              Eunie
            </label>
            <div id="ouroboros_eunie-item-hint" class="govuk-hint govuk-radios__hint">
              Come on, who else?
            </div>
          </div>
        '.to_one_line)
      end

      context 'and the hint has custom ID' do
        let(:hint_options) { { attributes: { id: 'custom-radio-item-hint-id' } } }

        it 'renders the radio item with the custom hint ID' do
          expect(radio_item_input_element[:'aria-describedby']).to eq('custom-radio-item-hint-id')
          expect(radio_item_element.find('div.govuk-hint')[:id]).to eq('custom-radio-item-hint-id')
        end
      end
    end

    context 'when there is conditional content within the item' do
      let(:conditional) do
        {
          content: 'Hello there!'
        }.merge(conditional_options)
      end
      let(:conditional_options) { {} }

      it 'correctly formats the HTML with the conditional item' do
        expect(radio_item_element.to_html).to eq('
          <div class="govuk-radios__item">
            <input class="govuk-radios__input" data-aria-controls="ouroboros_eunie_conditional" type="radio" value="eunie" name="test_model[ouroboros]" id="test_model_ouroboros_eunie">
            <label class="govuk-label govuk-radios__label" for="test_model_ouroboros_eunie">
              Eunie
            </label>
            <div class="govuk-radios__conditional govuk-radios__conditional--hidden" id="ouroboros_eunie_conditional">
              Hello there!
            </div>
          </div>
        '.to_one_line)
      end

      context 'when the item is checked' do
        let(:options) { { checked: true } }

        it 'does not hide the conditional content' do
          expect(radio_item_element.find_by_id('ouroboros_eunie_conditional')[:class]).to eq('govuk-radios__conditional')
        end
      end

      context 'when a custom ID is passed' do
        let(:conditional_options) { { attributes: { id: 'my-custom-conditional-id' } } }

        it 'has the custom id' do
          expect(radio_item_input_element[:'data-aria-controls']).to eq('my-custom-conditional-id')
          expect(radio_item_element.find('div')[:id]).to eq('my-custom-conditional-id')
        end
      end

      context 'when there are other data attributes' do
        let(:options) { { attributes: { data: { test: 'data-test' } } } }

        it 'has the both data attributes on the input' do
          expect(radio_item_input_element[:'data-test']).to eq('data-test')
          expect(radio_item_input_element[:'data-aria-controls']).to eq('ouroboros_eunie_conditional')
        end
      end
    end
  end
end
