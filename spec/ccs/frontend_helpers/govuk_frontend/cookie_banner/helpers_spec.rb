# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/cookie_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::CookieBanner, '#helpers', type: :helper do
  include described_class

  let(:cookie_banner_element) { Capybara::Node::Simple.new(result).find('div.govuk-cookie-banner') }
  let(:cookie_banner_messages_elements) { cookie_banner_element.all('div.govuk-cookie-banner__message', visible: false) }
  let(:cookie_banner_messages_element) { cookie_banner_messages_elements.first }
  let(:cookie_banner_message_actions) { cookie_banner_messages_element.find('div.govuk-button-group') }

  describe '.govuk_cookie_banner' do
    let(:result) { govuk_cookie_banner(messages, **options) }

    let(:messages) do
      [
        {
          heading_text: 'Cookies for Ouroboros',
          text: 'These are the cookies for ouroboros',
          actions: [
            {
              text: 'Accept ouroboros cookies',
              attributes: {
                name: 'cookies',
                value: 'accept'
              },
            },
            {
              text: 'Reject ouroboros cookies',
              attributes: {
                name: 'cookies',
                value: 'reject'
              },
            },
            {
              text: 'View ouroboros cookies',
              href: '#'
            }
          ]
        }.merge(message_options)
      ]
    end
    let(:options) { {} }
    let(:message_options) { {} }

    let(:default_html) do
      '
      <div class="govuk-cookie-banner" data-nosnippet="true" role="region" aria-label="Cookie banner">
        <div class="govuk-cookie-banner__message govuk-width-container">
          <div class="govuk-grid-row">
            <div class="govuk-grid-column-two-thirds">
              <h2 class="govuk-cookie-banner__heading govuk-heading-m">Cookies for Ouroboros</h2>
              <div class="govuk-cookie-banner__content">
                <p class="govuk-body">These are the cookies for ouroboros</p>
              </div>
            </div>
          </div>
          <div class="govuk-button-group">
            <button name="cookies" type="button" value="accept" class="govuk-button" data-module="govuk-button">
              Accept ouroboros cookies
            </button>
            <button name="cookies" type="button" value="reject" class="govuk-button" data-module="govuk-button">
              Reject ouroboros cookies
            </button>
            <a class="govuk-link" href="#">View ouroboros cookies</a>
          </div>
        </div>
      </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the heading text' do
        expect(cookie_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_cookie_banner(messages) }

      it 'correctly formats the HTML with the heading text' do
        expect(cookie_banner_element.to_html).to eq(default_html)
      end
    end
  end
end
