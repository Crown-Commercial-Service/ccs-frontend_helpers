# frozen_string_literal: true

require 'ccs/components/govuk/field/input/select'

RSpec.describe CCS::Components::GovUK::Field::Input::Select do
  include_context 'and I have a view context'

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:label_element) { Capybara::Node::Simple.new(result).find('label.govuk-label') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:select_element) { Capybara::Node::Simple.new(result).find('select.govuk-select') }
  let(:option_elements) { select_element.all('option') }

  let(:result) { govuk_select.render }

  let(:attribute) { 'ouroboros' }
  let(:select_items) do
    [
      {
        value: 'noah',
        text: 'Noah'
      },
      {
        value: 'mio',
        text: 'Mio'
      },
      {
        value: 'eunie',
        text: 'Eunie'
      },
      {
        value: 'taion',
        text: 'Taion'
      },
      {
        value: 'lanz',
        text: 'Lanz'
      },
      {
        value: 'sena',
        text: 'Sena'
      }
    ]
  end
  let(:error_message) { nil }
  let(:options) do
    {
      form_group: form_group_options,
      label: {
        text: 'Select your favourite characters'
      }.merge(label_options)
    }.merge(select_options)
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Select your favourite characters',
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: form_group_options,
      label: {
        text: 'Select your favourite characters'
      }.merge(label_options),
      hint: {
        text: 'Pick one option from the drop down'
      }.merge(hint_options)
    }.merge(select_options)
  end
  let(:form_group_options) { {} }
  let(:label_options) { {} }
  let(:hint_options) { {} }
  let(:select_options) { {} }
  let(:test_model) { TestModel.new }

  describe '.render' do
    let(:govuk_select) { described_class.new(attribute: attribute, items: select_items, error_message: error_message, context: view_context, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite characters
          </label>
          <select name="ouroboros" id="ouroboros" class="govuk-select">
            <option value="noah">Noah</option>
            <option value="mio">Mio</option>
            <option value="eunie">Eunie</option>
            <option value="taion">Taion</option>
            <option value="lanz">Lanz</option>
            <option value="sena">Sena</option>
          </select>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:govuk_select) { described_class.new(attribute: attribute, items: select_items, context: view_context, **options) }

      let(:options) { minimum_options }

      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:select_options) { { classes: 'my-custom-select-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(select_element[:class]).to eq('govuk-select my-custom-select-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:select_options) { { attributes: { id: 'my-custom-select-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(select_element[:id]).to eq('my-custom-select-id')
      end
    end

    context 'when a custom name is passed' do
      let(:select_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the select' do
        expect(select_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when custom attributes are passed' do
      let(:select_options) { { attributes: { multiple: true, aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      it 'has the additional attributes for the select' do
        expect(select_element[:multiple]).to eq('multiple')
        expect(select_element[:'aria-describedby']).to eq('some-id')
        expect(select_element[:'data-test']).to eq('my data value')
      end
    end

    context 'when the text is nil' do
      let(:select_items) do
        [
          {
            value: 'noah',
          },
          {
            value: 'mio',
          },
          {
            value: 'eunie',
          },
          {
            value: 'taion',
          },
          {
            value: 'lanz',
          },
          {
            value: 'sena',
          }
        ]
      end

      it 'correctly formats the HTML with value as the text' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <select name="ouroboros" id="ouroboros" class="govuk-select">
              <option value="noah">noah</option>
              <option value="mio">mio</option>
              <option value="eunie">eunie</option>
              <option value="taion">taion</option>
              <option value="lanz">lanz</option>
              <option value="sena">sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end

    context 'when the value is nil' do
      let(:select_items) do
        [
          {
            text: 'Noah'
          },
          {
            text: 'Mio'
          },
          {
            text: 'Eunie'
          },
          {
            text: 'Taion'
          },
          {
            text: 'Lanz'
          },
          {
            text: 'Sena'
          }
        ]
      end

      it 'correctly formats the HTML with text as the value' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <select name="ouroboros" id="ouroboros" class="govuk-select">
              <option value="Noah">Noah</option>
              <option value="Mio">Mio</option>
              <option value="Eunie">Eunie</option>
              <option value="Taion">Taion</option>
              <option value="Lanz">Lanz</option>
              <option value="Sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a prompt' do
      let(:select_options) { { attributes: { prompt: 'Come on, who else?' } } }

      it 'has the prompt option' do
        expect(select_element).to have_css('option[value=""]', text: 'Come on, who else?')
      end
    end

    context 'when one of the options is selected' do
      let(:select_options) { { selected: 'eunie' } }

      it 'has the correct selected option' do
        expect(select_element).to have_css('option[selected="selected"]', text: 'Eunie')
      end
    end

    context 'when options have additional attributes' do
      let(:select_items) do
        [
          {
            value: 'noah',
            text: 'Noah',
            attributes: {
              disabled: true
            }
          },
          {
            value: 'eunie',
            text: 'Eunie',
            attributes: {
              class: 'my-custom-class'
            }
          },
          {
            value: 'lanz',
            text: 'Lanz',
            attributes: {
              data: {
                test: 'my data value'
              }
            }
          }
        ]
      end

      it 'has the option disabled' do
        expect(option_elements[0][:disabled]).to eq('disabled')
        expect(option_elements[1][:class]).to eq('my-custom-class')
        expect(option_elements[2][:'data-test']).to eq('my data value')
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <select name="ouroboros" id="ouroboros" class="govuk-select" aria-describedby="ouroboros-hint">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
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

        it 'has the custom id for the hint and the select has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(select_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom and hint id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must select your favourite character' }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must select your favourite character
            </p>
            <select name="ouroboros" id="ouroboros" class="govuk-select govuk-select--error" aria-describedby="ouroboros-error">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom and error id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must select your favourite character' }
      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must select your favourite character
            </p>
            <select name="ouroboros" id="ouroboros" class="govuk-select govuk-select--error" aria-describedby="ouroboros-hint ouroboros-error">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom, hint and error id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when considering before and after input' do
      let(:before_input) { tag.p('I am before input', class: 'govuk-body') }
      let(:after_input) { tag.p('I am after input', class: 'govuk-body') }

      context 'when there is a before input' do
        let(:select_options) { { before_input: before_input } }

        it 'renders the select with the before input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <p class="govuk-body">
                I am before input
              </p>
              <select name="ouroboros" id="ouroboros" class="govuk-select">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is an after input' do
        let(:select_options) { { after_input: after_input } }

        it 'renders the select with the after input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <select name="ouroboros" id="ouroboros" class="govuk-select">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
              <p class="govuk-body">
                I am after input
              </p>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is a before and after input' do
        let(:select_options) { { before_input: before_input, after_input: after_input } }

        it 'renders the select with the before and after input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <p class="govuk-body">
                I am before input
              </p>
              <select name="ouroboros" id="ouroboros" class="govuk-select">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
              <p class="govuk-body">
                I am after input
              </p>
            </div>
          '.to_one_line)
        end
      end
    end
  end

  describe '.render with model' do
    let(:govuk_select) { described_class.new(attribute: attribute, items: select_items, model: test_model, context: view_context, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Select your favourite characters
          </label>
          <select name="ouroboros" id="ouroboros" class="govuk-select">
            <option value="noah">Noah</option>
            <option value="mio">Mio</option>
            <option value="eunie">Eunie</option>
            <option value="taion">Taion</option>
            <option value="lanz">Lanz</option>
            <option value="sena">Sena</option>
          </select>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:select_options) { { classes: 'my-custom-select-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(select_element[:class]).to eq('govuk-select my-custom-select-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:select_options) { { attributes: { id: 'my-custom-select-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(select_element[:id]).to eq('my-custom-select-id')
      end
    end

    context 'when a custom name is passed' do
      let(:select_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the select' do
        expect(select_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when custom attributes are passed' do
      let(:select_options) { { attributes: { multiple: true, aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      it 'has the additional attributes for the select' do
        expect(select_element[:multiple]).to eq('multiple')
        expect(select_element[:'aria-describedby']).to eq('some-id')
        expect(select_element[:'data-test']).to eq('my data value')
      end
    end

    context 'when the text is nil' do
      let(:select_items) do
        [
          {
            value: 'noah',
          },
          {
            value: 'mio',
          },
          {
            value: 'eunie',
          },
          {
            value: 'taion',
          },
          {
            value: 'lanz',
          },
          {
            value: 'sena',
          }
        ]
      end

      it 'correctly formats the HTML with value as the text' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <select name="ouroboros" id="ouroboros" class="govuk-select">
              <option value="noah">noah</option>
              <option value="mio">mio</option>
              <option value="eunie">eunie</option>
              <option value="taion">taion</option>
              <option value="lanz">lanz</option>
              <option value="sena">sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end

    context 'when the value is nil' do
      let(:select_items) do
        [
          {
            text: 'Noah'
          },
          {
            text: 'Mio'
          },
          {
            text: 'Eunie'
          },
          {
            text: 'Taion'
          },
          {
            text: 'Lanz'
          },
          {
            text: 'Sena'
          }
        ]
      end

      it 'correctly formats the HTML with text as the value' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <select name="ouroboros" id="ouroboros" class="govuk-select">
              <option value="Noah">Noah</option>
              <option value="Mio">Mio</option>
              <option value="Eunie">Eunie</option>
              <option value="Taion">Taion</option>
              <option value="Lanz">Lanz</option>
              <option value="Sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a prompt' do
      let(:select_options) { { attributes: { prompt: 'Come on, who else?' } } }

      it 'has the prompt option' do
        expect(select_element).to have_css('option[value=""]', text: 'Come on, who else?')
      end
    end

    context 'when one of the options is selected' do
      before { test_model.ouroboros = 'eunie' }

      it 'has the correct selected option' do
        expect(select_element).to have_css('option[selected="selected"]', text: 'Eunie')
      end
    end

    context 'when options have additional attributes' do
      let(:select_items) do
        [
          {
            value: 'noah',
            text: 'Noah',
            attributes: {
              disabled: true
            }
          },
          {
            value: 'eunie',
            text: 'Eunie',
            attributes: {
              class: 'my-custom-class'
            }
          },
          {
            value: 'lanz',
            text: 'Lanz',
            attributes: {
              data: {
                test: 'my data value'
              }
            }
          }
        ]
      end

      it 'has the option disabled' do
        expect(option_elements[0][:disabled]).to eq('disabled')
        expect(option_elements[1][:class]).to eq('my-custom-class')
        expect(option_elements[2][:'data-test']).to eq('my data value')
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <select name="ouroboros" id="ouroboros" class="govuk-select" aria-describedby="ouroboros-hint">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
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

        it 'has the custom id for the hint and the select has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(select_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom and hint id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { test_model.errors.add(:ouroboros, message: 'You must select your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must select your favourite character
            </p>
            <select name="ouroboros" id="ouroboros" class="govuk-select govuk-select--error" aria-describedby="ouroboros-error">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom and error id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }

      before { test_model.errors.add(:ouroboros, message: 'You must select your favourite character') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Select your favourite characters
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must select your favourite character
            </p>
            <select name="ouroboros" id="ouroboros" class="govuk-select govuk-select--error" aria-describedby="ouroboros-hint ouroboros-error">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom, hint and error id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when considering before and after input' do
      let(:before_input) { tag.p('I am before input', class: 'govuk-body') }
      let(:after_input) { tag.p('I am after input', class: 'govuk-body') }

      context 'when there is a before input' do
        let(:select_options) { { before_input: before_input } }

        it 'renders the select with the before input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <p class="govuk-body">
                I am before input
              </p>
              <select name="ouroboros" id="ouroboros" class="govuk-select">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is an after input' do
        let(:select_options) { { after_input: after_input } }

        it 'renders the select with the after input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <select name="ouroboros" id="ouroboros" class="govuk-select">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
              <p class="govuk-body">
                I am after input
              </p>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is a before and after input' do
        let(:select_options) { { before_input: before_input, after_input: after_input } }

        it 'renders the select with the before and after input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Select your favourite characters
              </label>
              <p class="govuk-body">
                I am before input
              </p>
              <select name="ouroboros" id="ouroboros" class="govuk-select">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
              <p class="govuk-body">
                I am after input
              </p>
            </div>
          '.to_one_line)
        end
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_select) { described_class.new(attribute: attribute, items: select_items, form: form, context: view_context, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Select your favourite characters
          </label>
          <select class="govuk-select" name="test_model[ouroboros]" id="test_model_ouroboros">
            <option value="noah">Noah</option>
            <option value="mio">Mio</option>
            <option value="eunie">Eunie</option>
            <option value="taion">Taion</option>
            <option value="lanz">Lanz</option>
            <option value="sena">Sena</option>
          </select>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:options) { minimum_options }

      it 'correctly formats the HTML with select in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:select_options) { { classes: 'my-custom-select-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(select_element[:class]).to eq('govuk-select my-custom-select-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:select_options) { { attributes: { id: 'my-custom-select-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(select_element[:id]).to eq('my-custom-select-id')
      end
    end

    context 'when a custom name is passed' do
      let(:select_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the select' do
        expect(select_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when custom attributes are passed' do
      let(:select_options) { { attributes: { multiple: true, aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      it 'has the additional attributes for the select' do
        expect(select_element[:multiple]).to eq('multiple')
        expect(select_element[:'aria-describedby']).to eq('some-id')
        expect(select_element[:'data-test']).to eq('my data value')
      end
    end

    context 'when the text is nil' do
      let(:select_items) do
        [
          {
            value: 'noah',
          },
          {
            value: 'mio',
          },
          {
            value: 'eunie',
          },
          {
            value: 'taion',
          },
          {
            value: 'lanz',
          },
          {
            value: 'sena',
          }
        ]
      end

      it 'correctly formats the HTML with value as the text' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Select your favourite characters
            </label>
            <select class="govuk-select" name="test_model[ouroboros]" id="test_model_ouroboros">
              <option value="noah">noah</option>
              <option value="mio">mio</option>
              <option value="eunie">eunie</option>
              <option value="taion">taion</option>
              <option value="lanz">lanz</option>
              <option value="sena">sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end

    context 'when the value is nil' do
      let(:select_items) do
        [
          {
            text: 'Noah'
          },
          {
            text: 'Mio'
          },
          {
            text: 'Eunie'
          },
          {
            text: 'Taion'
          },
          {
            text: 'Lanz'
          },
          {
            text: 'Sena'
          }
        ]
      end

      it 'correctly formats the HTML with text as the value' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Select your favourite characters
            </label>
            <select class="govuk-select" name="test_model[ouroboros]" id="test_model_ouroboros">
              <option value="Noah">Noah</option>
              <option value="Mio">Mio</option>
              <option value="Eunie">Eunie</option>
              <option value="Taion">Taion</option>
              <option value="Lanz">Lanz</option>
              <option value="Sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a prompt' do
      let(:select_options) { { attributes: { prompt: 'Come on, who else?' } } }

      it 'has the prompt option' do
        expect(select_element[:prompt]).to eq 'Come on, who else?'
      end
    end

    context 'when one of the options is selected' do
      before { test_model.ouroboros = 'eunie' }

      it 'has the correct selected option' do
        expect(select_element).to have_css('option[selected="selected"]', text: 'Eunie')
      end
    end

    context 'when options have additional attributes' do
      let(:select_items) do
        [
          {
            value: 'noah',
            text: 'Noah',
            attributes: {
              disabled: true
            }
          },
          {
            value: 'eunie',
            text: 'Eunie',
            attributes: {
              class: 'my-custom-class'
            }
          },
          {
            value: 'lanz',
            text: 'Lanz',
            attributes: {
              data: {
                test: 'my data value'
              }
            }
          }
        ]
      end

      it 'has the option disabled' do
        expect(option_elements[0][:disabled]).to eq('disabled')
        expect(option_elements[1][:class]).to eq('my-custom-class')
        expect(option_elements[2][:'data-test']).to eq('my data value')
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Select your favourite characters
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                Pick one option from the drop down
              </div>
              <select class="govuk-select" aria-describedby="ouroboros-hint" name="test_model[ouroboros]" id="test_model_ouroboros">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
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

        it 'has the custom id for the hint and the select has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(select_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom and hint id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { test_model.errors.add(:ouroboros, message: 'You must select your favourite character') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Select your favourite characters
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must select your favourite character
            </p>
            <select class="govuk-select govuk-select--error" aria-describedby="ouroboros-error" name="test_model[ouroboros]" id="test_model_ouroboros">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom and error id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      before { test_model.errors.add(:ouroboros, message: 'You must select your favourite character') }

      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Select your favourite characters
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              Pick one option from the drop down
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must select your favourite character
            </p>
            <select class="govuk-select govuk-select--error" aria-describedby="ouroboros-hint ouroboros-error" name="test_model[ouroboros]" id="test_model_ouroboros">
              <option value="noah">Noah</option>
              <option value="mio">Mio</option>
              <option value="eunie">Eunie</option>
              <option value="taion">Taion</option>
              <option value="lanz">Lanz</option>
              <option value="sena">Sena</option>
            </select>
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the select is passed' do
        let(:select_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the select aria described by as the custom, hint and error id' do
          expect(select_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end

    context 'when considering before and after input' do
      let(:before_input) { tag.p('I am before input', class: 'govuk-body') }
      let(:after_input) { tag.p('I am after input', class: 'govuk-body') }

      context 'when there is a before input' do
        let(:select_options) { { before_input: before_input } }

        it 'renders the select with the before input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Select your favourite characters
              </label>
              <p class="govuk-body">
                I am before input
              </p>
              <select class="govuk-select" name="test_model[ouroboros]" id="test_model_ouroboros">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is an after input' do
        let(:select_options) { { after_input: after_input } }

        it 'renders the select with the after input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Select your favourite characters
              </label>
              <select class="govuk-select" name="test_model[ouroboros]" id="test_model_ouroboros">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
              <p class="govuk-body">
                I am after input
              </p>
            </div>
          '.to_one_line)
        end
      end

      context 'when there is a before and after input' do
        let(:select_options) { { before_input: before_input, after_input: after_input } }

        it 'renders the select with the before and after input' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Select your favourite characters
              </label>
              <p class="govuk-body">
                I am before input
              </p>
              <select class="govuk-select" name="test_model[ouroboros]" id="test_model_ouroboros">
                <option value="noah">Noah</option>
                <option value="mio">Mio</option>
                <option value="eunie">Eunie</option>
                <option value="taion">Taion</option>
                <option value="lanz">Lanz</option>
                <option value="sena">Sena</option>
              </select>
              <p class="govuk-body">
                I am after input
              </p>
            </div>
          '.to_one_line)
        end
      end
    end
  end
end
