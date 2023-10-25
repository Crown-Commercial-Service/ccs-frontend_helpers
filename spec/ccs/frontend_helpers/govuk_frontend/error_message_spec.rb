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
  end

  describe 'govuk_error_message_with_model' do
    let(:result) { govuk_error_message_with_model(test_model, attribute, **options) }
    let(:test_model) { TestModel.new }

    before { test_model.errors.add(:ouroboros, message: message) }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the message and ID derived from the attribute' do
        expect(error_message_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_error_message_with_model(test_model, attribute) }

      it 'correctly formats the HTML with the message and ID derived from the attribute' do
        expect(error_message_element.to_html).to eq(default_html)
      end
    end

    context 'when there is no error message on the model' do
      before { test_model.errors.clear }

      it 'returns nil' do
        expect(result).to be_nil
      end
    end
  end
end
