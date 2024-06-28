# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/contact_us'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::ContactUs, '#helpers', type: :helper do
  include described_class

  let(:contact_us_element) { Capybara::Node::Simple.new(result).find('div.ccs-contact-us') }

  describe '.ccs_contact_us' do
    let(:result) { ccs_contact_us('/contact-us', **options) }

    let(:options) { {} }

    let(:default_html) do
      '
        <div class="ccs-contact-us">
          <div class="govuk-width-container">
            <div class="govuk-grid-row">
              <div class="govuk-grid-column-full">
                <p class="ccs-contact-us-body">
                  <strong class="ccs-contact-us-body__problems">Having problems with this service?</strong>
                  <a class="govuk-link" rel="noreferrer noopener" target="_blank" href="/contact-us">Contact us (opens in a new tab)</a>
                  for support.
                </p>
              </div>
            </div>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the contact us component' do
        expect(contact_us_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { ccs_contact_us('/contact-us') }

      it 'correctly formats the HTML for the contact us component' do
        expect(contact_us_element.to_html).to eq(default_html)
      end
    end
  end
end
