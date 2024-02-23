# frozen_string_literal: true

require 'ccs/components/govuk/error_message'

RSpec.describe CCS::Components::GovUK::ErrorMessage do
  include_context 'and I have a view context'

  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }

  describe '.render' do
    let(:govuk_error_message) { described_class.new(message: message, attribute: attribute, context: view_context, **options) }
    let(:result) { govuk_error_message.render }

    let(:message) { 'There is an enemy in our path' }
    let(:attribute) { 'ouroboros' }
    let(:options) { {} }

    let(:default_html) do
      '
        <p class="govuk-error-message" id="ouroboros-error">
          <span class="govuk-visually-hidden">Error: </span>
          There is an enemy in our path
        </p>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the message and ID derived from the attribute' do
        expect(error_message_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_error_message) { described_class.new(message: message, attribute: attribute, context: view_context) }

      it 'correctly formats the HTML with the message and ID derived from the attribute' do
        expect(error_message_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(error_message_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(error_message_element[:class]).to eq('govuk-error-message my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(error_message_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a custom visually hidden error prefix is passed' do
      let(:options) { { visually_hidden_text: 'Custom hidden text' } }

      it 'has the custom visually hidden error prefix' do
        expect(error_message_element).to have_css('span.govuk-visually-hidden', text: 'Custom hidden text: ')
      end
    end

    context 'when an empty custom visually hidden error prefix is passed' do
      let(:options) { { visually_hidden_text: '' } }

      it 'has no visually hidden prefix' do
        expect(error_message_element).to have_no_css('span.govuk-visually-hidden')
        expect(error_message_element).to have_content('There is an enemy in our path')
      end
    end
  end
end
