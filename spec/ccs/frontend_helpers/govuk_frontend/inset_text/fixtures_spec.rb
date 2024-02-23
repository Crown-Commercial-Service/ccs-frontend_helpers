# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/inset_text'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::InsetText, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_inset_text from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'inset-text' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_inset_text(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with html'" do
      let(:fixture_name) { 'with html' }
      let(:result) { govuk_inset_text(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_inset_text(fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_inset_text(fixture_options[:text], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_inset_text(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_inset_text(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
