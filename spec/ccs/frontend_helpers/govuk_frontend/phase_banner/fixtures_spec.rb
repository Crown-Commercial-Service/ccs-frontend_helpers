# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/phase_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::PhaseBanner, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_phase_banner from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'phase-banner' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_phase_banner(fixture_options[:tag], fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_phase_banner({ text: nil }, fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'text'" do
      let(:fixture_name) { 'text' }
      let(:result) { govuk_phase_banner({ text: nil }, fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_phase_banner({ text: nil }, fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_phase_banner({ text: nil }, fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'tag html'" do
      let(:fixture_name) { 'tag html' }
      let(:result) { govuk_phase_banner({ text: fixture_options[:tag][:html].html_safe }, fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'tag classes'" do
      let(:fixture_name) { 'tag classes' }
      let(:result) { govuk_phase_banner(fixture_options[:tag], fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
