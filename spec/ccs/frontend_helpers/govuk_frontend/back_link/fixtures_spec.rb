# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/back_link'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::BackLink, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_back_link from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'back-link' }

    before { fixture_options[:text] ||= 'Back' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_back_link(fixture_options[:text], fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom text'" do
      let(:fixture_name) { 'with custom text' }
      let(:result) { govuk_back_link(fixture_options[:text], fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'inverse'" do
      let(:fixture_name) { 'inverse' }
      let(:result) { govuk_back_link(fixture_options[:text], fixture_options[:href], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_back_link(fixture_options[:text], fixture_options[:href], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_back_link(fixture_options[:text], fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_back_link(fixture_options[:html].html_safe, fixture_options[:href]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_back_link(fixture_options[:html].html_safe, fixture_options[:href], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
