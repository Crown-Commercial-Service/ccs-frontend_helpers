# frozen_string_literal: true

require 'ccs/components/ccs/contact_us'

RSpec.describe CCS::Components::CCS::ContactUs do
  include_context 'and I have a view context'

  let(:contact_us_element) { Capybara::Node::Simple.new(result).find('div.ccs-contact-us') }

  describe '.render' do
    let(:ccs_contact_us) { described_class.new(contact_us_link_href: '/contact-us', context: view_context, **options) }
    let(:result) { ccs_contact_us.render }

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
      it 'correctly formats the HTML for the contact us' do
        expect(contact_us_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:ccs_contact_us) { described_class.new(contact_us_link_href: '/contact-us', context: view_context) }

      it 'correctly formats the HTML for the contact us' do
        expect(contact_us_element.to_html).to eq(default_html)
      end
    end

    context 'when custom text is given' do
      let(:ccs_contact_us) { described_class.new(contact_us_link_href: '/contact-us-now', having_problems_text: 'Are you having problems?', contact_us_link_text: 'Go on, contact us (opens in new tab)', contact_us_text: 'you know you want to.', context: view_context, **options) }

      it 'correctly formats the HTML for contact us with the custom text' do
        expect(contact_us_element.to_html).to eq('
          <div class="ccs-contact-us">
            <div class="govuk-width-container">
              <div class="govuk-grid-row">
                <div class="govuk-grid-column-full">
                  <p class="ccs-contact-us-body">
                    <strong class="ccs-contact-us-body__problems">Are you having problems?</strong>
                    <a class="govuk-link" rel="noreferrer noopener" target="_blank" href="/contact-us-now">Go on, contact us (opens in new tab)</a>
                    you know you want to.
                  </p>
                </div>
              </div>
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(contact_us_element[:class]).to eq('ccs-contact-us my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(contact_us_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
