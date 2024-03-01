# frozen_string_literal: true

require 'ccs/components/govuk/cookie_banner'

RSpec.describe CCS::Components::GovUK::CookieBanner do
  include_context 'and I have a view context'

  let(:cookie_banner_element) { Capybara::Node::Simple.new(result).find('div.govuk-cookie-banner') }
  let(:cookie_banner_messages_elements) { cookie_banner_element.all('div.govuk-cookie-banner__message', visible: false) }

  describe '.render' do
    let(:govuk_cookie_banner) { described_class.new(messages: messages, context: view_context, **options) }
    let(:result) { govuk_cookie_banner.render }

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
        }
      ]
    end
    let(:options) { {} }

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
      let(:govuk_cookie_banner) { described_class.new(messages: messages, context: view_context) }

      it 'correctly formats the HTML with the heading text' do
        expect(cookie_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(cookie_banner_element[:class]).to eq('govuk-cookie-banner my-custom-class')
      end
    end

    context 'when an aria-label is passed' do
      let(:options) { { attributes: { aria: { label: 'My custom aria label' } } } }

      it 'has the custom aria label' do
        expect(cookie_banner_element[:'aria-label']).to eq('My custom aria label')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { 'disable-auto-focus': 'true' } } } }

      it 'has the additional attributes' do
        expect(cookie_banner_element[:id]).to eq('my-custom-id')
        expect(cookie_banner_element[:'data-disable-auto-focus']).to eq('true')
        expect(cookie_banner_element[:'data-nosnippet']).to eq('true')
      end
    end

    context 'and there are multiple messages' do
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
          },
          {
            text: 'You’ve accepted additional cookies',
            actions: [
              {
                text: 'Hide cookie message',
              }
            ],
            attributes: {
              hidden: true
            }
          },
          {
            text: 'You’ve rejected additional cookies',
            actions: [
              {
                text: 'Hide cookie message',
              }
            ],
            attributes: {
              hidden: true
            }
          }
        ]
      end

      it 'creates three message sections' do
        expect(cookie_banner_messages_elements.length).to eq(3)
      end

      it 'the first section is visible' do
        expect(cookie_banner_messages_elements[0]).to be_visible
      end

      it 'the second and third section is not visible' do
        expect(cookie_banner_messages_elements[1]).not_to be_visible
        expect(cookie_banner_messages_elements[2]).not_to be_visible
      end
    end
  end
end
