# frozen_string_literal: true

require 'ccs/components/govuk/button'

RSpec.describe CCS::Components::GovUK::Button do
  include_context 'and I have a view context'

  describe '.render' do
    let(:button_element) { Capybara::Node::Simple.new(result).find('a.govuk-button') }

    let(:govuk_button) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_button.render }

    let(:text) { 'Go Beyond, Plus Ultra!' }
    let(:options) { {} }

    context 'when the type of button is a link' do
      let(:options) { { href: 'https://github.com/tim-s-ccs/ccs-frontend_helpers' } }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq('
            <a class="govuk-button" data-module="govuk-button" role="button" draggable="false" href="https://github.com/tim-s-ccs/ccs-frontend_helpers">
              Go Beyond, Plus Ultra!
            </a>
          '.to_one_line)
        end
      end

      context 'when custom attributes are sent' do
        let(:options) { super().merge({ attributes: { aria: { controls: 'example-id' }, data: { 'tracking-dimension': '123' } } }) }

        it 'has the additional attributes' do
          expect(button_element[:'aria-controls']).to eq('example-id')
          expect(button_element[:'data-tracking-dimension']).to eq('123')
        end
      end

      context 'when additional classes are passed' do
        let(:options) { super().merge({ classes: 'my-custom-class' }) }

        it 'has the custom class' do
          expect(button_element[:class]).to eq('govuk-button my-custom-class')
        end
      end

      context 'when the disabled attribute is passed' do
        let(:options) { super().merge({ attributes: { disabled: :diabled } }) }

        it 'has the disabled attribute' do
          expect(button_element[:disabled]).to eq('disabled')
          expect(button_element[:'aria-disabled']).to eq('true')
        end
      end

      context 'when it is a start button' do
        let(:options) { super().merge({ is_start_button: true }) }

        it 'correctly formats the HTML with the start button image' do
          expect(button_element.to_html).to eq('
            <a class="govuk-button govuk-button--start" data-module="govuk-button" role="button" draggable="false" href="https://github.com/tim-s-ccs/ccs-frontend_helpers">
              Go Beyond, Plus Ultra!
              <svg class="govuk-button__start-icon" xmlns="http://www.w3.org/2000/svg" width="17.5" height="19" viewbox="0 0 33 40" aria-hidden="true" focusable="false">
                <path fill="currentColor" d="M0 0h13l20 20-20 20H0l20-20z"></path>
              </svg>
            </a>
          '.to_one_line)
        end
      end
    end

    context 'when the type of button is a submit input' do
      include_context 'and I have a form'

      let(:button_element) { Capybara::Node::Simple.new(result).find('input.govuk-button') }

      let(:options) { { form: form } }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq('<input type="submit" name="commit" value="Go Beyond, Plus Ultra!" class="govuk-button" data-module="govuk-button" data-disable-with="Go Beyond, Plus Ultra!">')
        end
      end

      context 'when custom attributes are sent' do
        let(:options) { super().merge({ attributes: { aria: { controls: 'example-id' }, data: { 'tracking-dimension': '123' } } }) }

        it 'has the additional attributes' do
          expect(button_element[:'aria-controls']).to eq('example-id')
          expect(button_element[:'data-tracking-dimension']).to eq('123')
        end
      end

      context 'when additional classes are passed' do
        let(:options) { super().merge({ classes: 'my-custom-class' }) }

        it 'has the custom class' do
          expect(button_element[:class]).to eq('govuk-button my-custom-class')
        end
      end

      context 'when the disabled attribute is passed' do
        let(:options) { super().merge({ attributes: { disabled: :diabled } }) }

        it 'has the disabled attribute' do
          expect(button_element[:disabled]).to eq('disabled')
        end
      end

      context 'when the name attribute is passed' do
        let(:options) { super().merge({ attributes: { name: 'go-beyond' } }) }

        it 'has the custom name attribute' do
          expect(button_element[:name]).to eq('go-beyond')
        end
      end

      context 'when the value attribute is passed' do
        let(:options) { super().merge({ attributes: { value: 'plus-ultra' } }) }

        it 'has the value attribute' do
          expect(button_element[:value]).to eq('plus-ultra')
        end
      end
    end

    context 'when the type of button is a button' do
      let(:button_element) { Capybara::Node::Simple.new(result).find('button.govuk-button') }

      let(:default_html) do
        '
          <button name="button" type="submit" class="govuk-button" data-module="govuk-button">
            Go Beyond, Plus Ultra!
          </button>
        '.to_one_line
      end

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq(default_html)
        end
      end

      context 'when the no options are sent' do
        let(:govuk_button) { described_class.new(text: text, context: view_context) }

        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq(default_html)
        end
      end

      context 'when custom attributes are sent' do
        let(:options) { super().merge({ attributes: { aria: { controls: 'example-id' }, data: { 'tracking-dimension': '123' } } }) }

        it 'has the additional attributes' do
          expect(button_element[:'aria-controls']).to eq('example-id')
          expect(button_element[:'data-tracking-dimension']).to eq('123')
        end
      end

      context 'when additional classes are passed' do
        let(:options) { super().merge({ classes: 'my-custom-class' }) }

        it 'has the custom class' do
          expect(button_element[:class]).to eq('govuk-button my-custom-class')
        end
      end

      context 'when the disabled attribute is passed' do
        let(:options) { super().merge({ attributes: { disabled: :diabled } }) }

        it 'has the disabled attribute' do
          expect(button_element[:disabled]).to eq('disabled')
        end
      end

      context 'when the name attribute is passed' do
        let(:options) { super().merge({ attributes: { name: 'go-beyond' } }) }

        it 'has the custom name attribute' do
          expect(button_element[:name]).to eq('go-beyond')
        end
      end

      context 'when the value attribute is passed' do
        let(:options) { super().merge({ attributes: { value: 'plus-ultra' } }) }

        it 'has the value attribute' do
          expect(button_element[:value]).to eq('plus-ultra')
        end
      end

      context 'when the type is reset' do
        let(:options) { super().merge({ attributes: { type: 'reset' } }) }

        it 'has the type attribute as reset' do
          expect(button_element[:type]).to eq('reset')
        end
      end

      context 'when it is a start button' do
        let(:options) { { is_start_button: true } }

        it 'correctly formats the HTML with the start button image' do
          expect(button_element.to_html).to eq('
            <button name="button" type="submit" class="govuk-button govuk-button--start" data-module="govuk-button">
              Go Beyond, Plus Ultra!
              <svg class="govuk-button__start-icon" xmlns="http://www.w3.org/2000/svg" width="17.5" height="19" viewbox="0 0 33 40" aria-hidden="true" focusable="false">
                <path fill="currentColor" d="M0 0h13l20 20-20 20H0l20-20z"></path>
              </svg>
            </button>
          '.to_one_line)
        end
      end
    end
  end
end
