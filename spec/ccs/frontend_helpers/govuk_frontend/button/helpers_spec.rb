# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/button'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Button, '#helpers', type: :helper do
  include described_class

  describe '.govuk_button' do
    let(:result) { govuk_button(text, **options) }

    let(:text) { 'Go Beyond, Plus Ultra!' }
    let(:options) { {} }

    context 'when type is a' do
      let(:options) { { href: 'https://github.com/tim-s-ccs/ccs-frontend_helpers' } }

      let(:button_element) { Capybara::Node::Simple.new(result).find('a.govuk-button') }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq('
            <a class="govuk-button" data-module="govuk-button" role="button" draggable="false" href="https://github.com/tim-s-ccs/ccs-frontend_helpers">
              Go Beyond, Plus Ultra!
            </a>
          '.to_one_line)
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

    context 'when type is submit' do
      include_context 'and I have a view context from self'
      include_context 'and I have a form'

      let(:options) { { form: form } }

      let(:button_element) { Capybara::Node::Simple.new(result).find('input.govuk-button') }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq('<input type="submit" name="commit" value="Go Beyond, Plus Ultra!" class="govuk-button" data-module="govuk-button" data-disable-with="Go Beyond, Plus Ultra!">')
        end
      end
    end

    context 'when type is button' do
      let(:default_html) do
        '
          <button name="button" type="submit" class="govuk-button" data-module="govuk-button">
            Go Beyond, Plus Ultra!
          </button>
        '.to_one_line
      end

      let(:button_element) { Capybara::Node::Simple.new(result).find('button.govuk-button') }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq(default_html)
        end
      end

      context 'when the no options are sent' do
        let(:result) { govuk_button(text) }

        it 'correctly formats the HTML with the text and content' do
          expect(button_element.to_html).to eq(default_html)
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
