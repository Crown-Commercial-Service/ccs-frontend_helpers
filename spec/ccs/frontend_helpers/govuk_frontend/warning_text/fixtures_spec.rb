# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/warning_text'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::WarningText, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_warning_text from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'warning-text' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_warning_text(fixture_options[:text], icon_fallback_text: fixture_options[:iconFallbackText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'multiple lines'" do
      let(:fixture_name) { 'multiple lines' }
      let(:result) { govuk_warning_text(fixture_options[:text], icon_fallback_text: fixture_options[:iconFallbackText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_warning_text(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_warning_text(fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_warning_text(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_warning_text(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'icon fallback text only'" do
      let(:fixture_name) { 'icon fallback text only' }
      let(:result) { govuk_warning_text('', icon_fallback_text: fixture_options[:iconFallbackText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'no icon fallback text'" do
      let(:fixture_name) { 'no icon fallback text' }
      let(:result) { govuk_warning_text(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
