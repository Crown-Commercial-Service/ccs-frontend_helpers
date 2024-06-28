# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/contact_us'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::ContactUs, '#fixtures', type: :helper do
  include described_class

  describe '.ccs_contact_us from fixtures' do
    include_context 'and I have loaded the CCS Frontend fixture'

    let(:component_name) { 'contact-us' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { ccs_contact_us(fixture_options[:contactUsLink][:href]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom text'" do
      let(:fixture_name) { 'with custom text' }
      let(:result) { ccs_contact_us(fixture_options[:contactUsLink][:href], having_problems_text: fixture_options[:havingProblemsText], contact_us_link_text: fixture_options[:contactUsLink][:text], contact_us_text: fixture_options[:contactUsText]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with no contact us text'" do
      let(:fixture_name) { 'with no contact us text' }
      let(:result) { ccs_contact_us('/contact-us-now', contact_us_text: fixture_options[:contactUsText]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { ccs_contact_us(fixture_options[:contactUsLink][:href], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { ccs_contact_us(fixture_options[:contactUsLink][:href], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
