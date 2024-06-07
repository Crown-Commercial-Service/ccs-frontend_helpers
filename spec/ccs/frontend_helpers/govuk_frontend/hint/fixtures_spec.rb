# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/hint'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Hint, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_hint from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'hint' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_hint(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with html'" do
      let(:fixture_name) { 'with html' }
      let(:result) { govuk_hint(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_hint(fixture_options[:text], classes: fixture_options[:classes], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_hint(fixture_options[:text], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_hint(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_hint(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
