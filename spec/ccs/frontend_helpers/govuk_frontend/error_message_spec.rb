# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/error_message'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ErrorMessage, type: :helper do
  include described_class

  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }

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

  describe '.govuk_error_message' do
    let(:result) { govuk_error_message(message, attribute, **options) }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the message and ID derived from the attribute' do
        expect(error_message_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_error_message(message, attribute) }

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
        expect(error_message_element).not_to have_css('span.govuk-visually-hidden')
        expect(error_message_element).to have_content('There is an enemy in our path')
      end
    end
  end

  describe 'govuk_error_message_with_model' do
    let(:result) { govuk_error_message_with_model(model, attribute, **options) }
    let(:model) { TestModel.new }

    before { model.errors.add(:ouroboros, message: message) }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the message and ID derived from the attribute' do
        expect(error_message_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_error_message_with_model(model, attribute) }

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
        expect(error_message_element).not_to have_css('span.govuk-visually-hidden')
        expect(error_message_element).to have_content('There is an enemy in our path')
      end
    end

    context 'when there is no error message on the model' do
      before { model.errors.clear }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end
end
