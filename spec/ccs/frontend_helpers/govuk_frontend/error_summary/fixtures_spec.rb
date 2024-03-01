# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/error_summary'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ErrorSummary, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_error_summary from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'error-summary' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'without links'" do
      let(:fixture_name) { 'without links' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'mixed with and without links'" do
      let(:fixture_name) { 'mixed with and without links' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with everything'" do
      let(:fixture_name) { 'with everything' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList], fixture_options[:descriptionText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as titleText'" do
      let(:fixture_name) { 'html as titleText' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'title html'" do
      let(:fixture_name) { 'title html' }
      let(:result) { govuk_error_summary(fixture_options[:titleHtml].html_safe, fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'description'" do
      let(:fixture_name) { 'description' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList], fixture_options[:descriptionText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as descriptionText'" do
      let(:fixture_name) { 'html as descriptionText' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList], fixture_options[:descriptionText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'description html'" do
      let(:fixture_name) { 'description html' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList], fixture_options[:descriptionHtml].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error list with attributes'" do
      let(:fixture_name) { 'error list with attributes' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error list with html as text'" do
      let(:fixture_name) { 'error list with html as text' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error list with html'" do
      let(:fixture_name) { 'error list with html' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList].map { |item| { text: item[:html].html_safe } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error list with html link'" do
      let(:fixture_name) { 'error list with html link' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList].map { |item| { href: item[:href], text: item[:html].html_safe } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error list with html as text link'" do
      let(:fixture_name) { 'error list with html as text link' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], fixture_options[:errorList]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'autofocus disabled'" do
      let(:fixture_name) { 'autofocus disabled' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], [], attributes: { data: { 'disable-auto-focus': fixture_options[:disableAutoFocus] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'autofocus explicitly enabled'" do
      let(:fixture_name) { 'autofocus explicitly enabled' }
      let(:result) { govuk_error_summary(fixture_options[:titleText], [], attributes: { data: { 'disable-auto-focus': fixture_options[:disableAutoFocus] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
