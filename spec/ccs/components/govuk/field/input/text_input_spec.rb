# frozen_string_literal: true

require 'ccs/components/govuk/field/input/text_input'

RSpec.describe CCS::Components::GovUK::Field::Input::TextInput do
  include_context 'and I have a view context'

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:label_element) { Capybara::Node::Simple.new(result).find('label.govuk-label') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:input_element) { Capybara::Node::Simple.new(result).find('input.govuk-input') }
  let(:input_wrapper_element) { Capybara::Node::Simple.new(result).find('div.govuk-input__wrapper') }

  let(:result) { govuk_text_input.render }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: form_group_options,
      label: {
        text: 'Select your favourite character'
      }.merge(label_options)
    }.merge(input_options)
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Select your favourite character',
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: form_group_options,
      label: {
        text: 'Select your favourite character'
      }.merge(label_options),
      hint: {
        text: 'Pick one option from the drop down'
      }.merge(hint_options)
    }.merge(input_options)
  end
  let(:form_group_options) { {} }
  let(:label_options) { {} }
  let(:hint_options) { {} }
  let(:input_options) { {} }
  let(:test_model) { TestModel.new }

  describe '.render' do
    let(:govuk_text_input) { described_class.new(attribute: attribute, error_message: error_message, context: view_context, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite character
          </label>
          <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_text_input) { described_class.new(attribute: attribute, context: view_context, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:input_options) { { classes: 'my-custom-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(input_element[:class]).to eq('govuk-input my-custom-input-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:input_options) { { attributes: { id: 'my-custom-input-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(input_element[:id]).to eq('my-custom-input-id')
      end
    end

    context 'when a custom name is passed' do
      let(:input_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the input' do
        expect(input_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom type is passed' do
      let(:input_options) { { attributes: { type: 'number' } } }

      it 'has the custom type in the input' do
        expect(input_element[:type]).to eq('number')
      end
    end

    context 'when a field_type is passed' do
      let(:input_options) { { field_type: field_type } }

      context 'and it is password' do
        let(:field_type) { :password }

        it 'has the type in the input is the password' do
          expect(input_element[:type]).to eq('password')
        end
      end

      context 'and it is email' do
        let(:field_type) { :email }

        it 'has the type in the input is the email' do
          expect(input_element[:type]).to eq('email')
        end
      end

      context 'and it is search' do
        let(:field_type) { :search }

        it 'has the type in the input is the search' do
          expect(input_element[:type]).to eq('search')
        end
      end
    end

    context 'when custom attributes are passed' do
      let(:input_options) { { attributes: { pattern: '[0-9]*', value: 'Eunie', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the additional attributes for the input' do
        expect(input_element[:value]).to eq('Eunie')
        expect(input_element[:pattern]).to eq('[0-9]*')
        expect(input_element[:'aria-describedby']).to eq('some-id')
        expect(input_element[:'data-test']).to eq('my data value')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite character
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <input type="text" name="ouroboros" id="ouroboros" class="govuk-input" aria-describedby="ouroboros-hint">
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

        it 'has the custom id for the hint and the input has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(input_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and hint id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must enter your favourite character' }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite character
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input govuk-input--error" aria-describedby="ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and error id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must enter your favourite character' }
      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite character
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom, hint and error id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'and it includes a prefix' do
      let(:input_options) { { prefix: { text: '£' } } }

      it 'correctly formats the input HTML with the prefix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
          </div>
        '.to_one_line)
      end
    end

    context 'and it includes a suffix' do
      let(:input_options) { { suffix: { text: 'per week' } } }

      it 'correctly formats the input HTML with the suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when it includes both a prefix and suffix' do
      let(:input_options) { { prefix: { text: '£' }, suffix: { text: 'per week' } } }

      it 'correctly formats the input HTML with the prefix and suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.render with model' do
    let(:govuk_text_input) { described_class.new(attribute: attribute, model: test_model, context: view_context, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite character
          </label>
          <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:input_options) { { classes: 'my-custom-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(input_element[:class]).to eq('govuk-input my-custom-input-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:input_options) { { attributes: { id: 'my-custom-input-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(input_element[:id]).to eq('my-custom-input-id')
      end
    end

    context 'when a custom name is passed' do
      let(:input_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the input' do
        expect(input_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom type is passed' do
      let(:input_options) { { attributes: { type: 'number' } } }

      it 'has the custom type in the input' do
        expect(input_element[:type]).to eq('number')
      end
    end

    context 'when a field_type is passed' do
      let(:input_options) { { field_type: field_type } }

      context 'and it is password' do
        let(:field_type) { :password }

        it 'has the type in the input is the password' do
          expect(input_element[:type]).to eq('password')
        end
      end

      context 'and it is email' do
        let(:field_type) { :email }

        it 'has the type in the input is the email' do
          expect(input_element[:type]).to eq('email')
        end
      end

      context 'and it is search' do
        let(:field_type) { :search }

        it 'has the type in the input is the search' do
          expect(input_element[:type]).to eq('search')
        end
      end
    end

    context 'when the model has a value' do
      before { test_model.ouroboros = 'Eunie' }

      it 'has the value for the input' do
        expect(input_element[:value]).to eq('Eunie')
      end
    end

    context 'when custom attributes are passed' do
      let(:input_options) { { attributes: { pattern: '[0-9]*', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      it 'has the additional attributes for the input' do
        expect(input_element[:pattern]).to eq('[0-9]*')
        expect(input_element[:'aria-describedby']).to eq('some-id')
        expect(input_element[:'data-test']).to eq('my data value')
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite character
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <input type="text" name="ouroboros" id="ouroboros" class="govuk-input" aria-describedby="ouroboros-hint">
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

        it 'has the custom id for the hint and the input has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(input_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and hint id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite character
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input govuk-input--error" aria-describedby="ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and error id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }

      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite character
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom, hint and error id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'and it includes a prefix' do
      let(:input_options) { { prefix: { text: '£' } } }

      it 'correctly formats the input HTML with the prefix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
          </div>
        '.to_one_line)
      end
    end

    context 'and it includes a suffix' do
      let(:input_options) { { suffix: { text: 'per week' } } }

      it 'correctly formats the input HTML with the suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when it includes both a prefix and suffix' do
      let(:input_options) { { prefix: { text: '£' }, suffix: { text: 'per week' } } }

      it 'correctly formats the input HTML with the prefix and suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input type="text" name="ouroboros" id="ouroboros" class="govuk-input">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_text_input) { described_class.new(attribute: attribute, form: form, context: view_context, **options) }

    let(:defeat_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Select your favourite character
          </label>
          <input class="govuk-input" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end

    context 'when the model has a value' do
      before { test_model.ouroboros = 'Eunie' }

      it 'has the value for the input' do
        expect(input_element[:value]).to eq('Eunie')
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:input_options) { { classes: 'my-custom-input-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(input_element[:class]).to eq('govuk-input my-custom-input-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:input_options) { { attributes: { id: 'my-custom-input-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(input_element[:id]).to eq('my-custom-input-id')
      end
    end

    context 'when a custom name is passed' do
      let(:input_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the input' do
        expect(input_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom type is passed' do
      let(:input_options) { { attributes: { type: 'number' } } }

      it 'has the custom type in the input' do
        expect(input_element[:type]).to eq('number')
      end
    end

    context 'when a field_type is passed' do
      let(:input_options) { { field_type: field_type } }

      context 'and it is password' do
        let(:field_type) { :password }

        it 'has the type in the input is the password' do
          expect(input_element[:type]).to eq('password')
        end
      end

      context 'and it is email' do
        let(:field_type) { :email }

        it 'has the type in the input is the email' do
          expect(input_element[:type]).to eq('email')
        end
      end

      context 'and it is search' do
        let(:field_type) { :search }

        it 'has the type in the input is the search' do
          expect(input_element[:type]).to eq('search')
        end
      end
    end

    context 'when custom attributes are passed' do
      let(:input_options) { { attributes: { pattern: '[0-9]*', value: 'Eunie', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the additional attributes for the input' do
        expect(input_element[:value]).to eq('Eunie')
        expect(input_element[:pattern]).to eq('[0-9]*')
        expect(input_element[:'aria-describedby']).to eq('some-id')
        expect(input_element[:'data-test']).to eq('my data value')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Select your favourite character
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <input class="govuk-input" aria-describedby="ouroboros-hint" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
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

        it 'has the custom id for the hint and the input has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(input_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and hint id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Select your favourite character
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <input class="govuk-input govuk-input--error" aria-describedby="ouroboros-error" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom and error id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }

      before { test_model.errors.add(:ouroboros, message: 'You must enter your favourite character') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Select your favourite character
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must enter your favourite character
            </p>
            <input class="govuk-input govuk-input--error" aria-describedby="ouroboros-hint ouroboros-error" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the input is passed' do
        let(:input_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the input aria described by as the custom, hint and error id' do
          expect(input_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'and it includes a prefix' do
      let(:input_options) { { prefix: { text: '£' } } }

      it 'correctly formats the input HTML with the prefix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input class="govuk-input" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
          </div>
        '.to_one_line)
      end
    end

    context 'and it includes a suffix' do
      let(:input_options) { { suffix: { text: 'per week' } } }

      it 'correctly formats the input HTML with the suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <input class="govuk-input" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when it includes both a prefix and suffix' do
      let(:input_options) { { prefix: { text: '£' }, suffix: { text: 'per week' } } }

      it 'correctly formats the input HTML with the prefix and suffix' do
        expect(input_wrapper_element.to_html).to eq('
          <div class="govuk-input__wrapper">
            <div class="govuk-input__prefix" aria-hidden="true">
              £
            </div>
            <input class="govuk-input" type="text" name="test_model[ouroboros]" id="test_model_ouroboros">
            <div class="govuk-input__suffix" aria-hidden="true">
              per week
            </div>
          </div>
        '.to_one_line)
      end
    end
  end
end
