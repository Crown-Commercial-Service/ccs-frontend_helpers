# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/skip_link'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::SkipLink, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_skip_link from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'skip-link' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_skip_link(fixture_options[:text], fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with focus'" do
      let(:fixture_name) { 'with focus' }
      let(:result) { govuk_skip_link(fixture_options[:text], fixture_options[:href], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'no href'" do
      let(:fixture_name) { 'no href' }
      let(:result) { govuk_skip_link(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom href'" do
      let(:fixture_name) { 'custom href' }
      let(:result) { govuk_skip_link(fixture_options[:text], fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom text'" do
      let(:fixture_name) { 'custom text' }
      let(:result) { govuk_skip_link(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_skip_link(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_skip_link(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_skip_link(fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_skip_link(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
