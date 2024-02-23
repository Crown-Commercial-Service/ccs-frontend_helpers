# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/error_message'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ErrorMessage, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_error_message from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'error-message' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_error_message(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'translated'" do
      let(:fixture_name) { 'translated' }
      let(:result) { govuk_error_message(fixture_options[:html].html_safe, visually_hidden_text: fixture_options[:visuallyHiddenText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_error_message(fixture_options[:text], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_error_message(fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_error_message(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_error_message(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_error_message(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with visually hidden text'" do
      let(:fixture_name) { 'with visually hidden text' }
      let(:result) { govuk_error_message(fixture_options[:text], visually_hidden_text: fixture_options[:visuallyHiddenText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'visually hidden text removed'" do
      let(:fixture_name) { 'visually hidden text removed' }
      let(:result) { govuk_error_message(fixture_options[:text], visually_hidden_text: fixture_options[:visuallyHiddenText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
