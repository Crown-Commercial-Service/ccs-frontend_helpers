# frozen_string_literal: true

require 'ccs/components/govuk/cookie_banner/message'

RSpec.describe CCS::Components::GovUK::CookieBanner::Message do
  include_context 'and I have a view context'

  let(:cookie_banner_messages_element) { Capybara::Node::Simple.new(result).find('div.govuk-cookie-banner__message') }
  let(:cookie_banner_message_actions) { cookie_banner_messages_element.find('div.govuk-button-group') }

  describe '.render' do
    let(:govuk_cookie_banner_message) { described_class.new(heading_text: heading_text, content: content, text: text, actions: actions, context: view_context, **options) }
    let(:result) { govuk_cookie_banner_message.render }

    let(:heading_text) { 'Cookies for Ouroboros' }
    let(:content) { nil }
    let(:text) { 'These are the cookies for ouroboros' }
    let(:actions) do
      [
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
    end
    let(:options) { {} }

    let(:default_html) do
      '
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
          <button name="cookies" type="submit" value="accept" class="govuk-button" data-module="govuk-button">
            Accept ouroboros cookies
          </button>
          <button name="cookies" type="submit" value="reject" class="govuk-button" data-module="govuk-button">
            Reject ouroboros cookies
          </button>
          <a class="govuk-link" href="#">View ouroboros cookies</a>
        </div>
      </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the heading and text' do
        expect(cookie_banner_messages_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_cookie_banner_message) { described_class.new(heading_text: heading_text, content: content, text: text, actions: actions, context: view_context) }

      it 'correctly formats the HTML with the heading and text' do
        expect(cookie_banner_messages_element.to_html).to eq(default_html)
      end
    end

    context 'and additional classes are passed' do
      let(:options) { { classes: 'my-custom-message-class' } }

      it 'has the custom class' do
        expect(cookie_banner_messages_element[:class]).to eq('govuk-cookie-banner__message govuk-width-container my-custom-message-class')
      end
    end

    context 'and a role is passed' do
      let(:options) { { attributes: { role: 'alert' } } }

      it 'has the role' do
        expect(cookie_banner_messages_element[:role]).to eq('alert')
      end
    end

    context 'and additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-message-id', data: { test: 'hello-there' } } } }

      it 'has the additional attributes' do
        expect(cookie_banner_messages_element[:id]).to eq('my-custom-message-id')
        expect(cookie_banner_messages_element[:'data-test']).to eq('hello-there')
      end
    end

    context 'when content is passed' do
      let(:content) { tag.div('Here is the content', class: 'my-random-content') }

      it 'renders the content' do
        expect(cookie_banner_messages_element).to have_css('div.my-random-content', text: 'Here is the content')
      end
    end

    context 'when content and text is passed' do
      let(:content) { tag.div('Here is the content', class: 'my-random-content') }
      let(:text) { 'Here is the text' }

      it 'renders the content only' do
        expect(cookie_banner_messages_element).not_to have_css('p.govuk-body', text: 'Here is the text')
        expect(cookie_banner_messages_element).to have_css('div.my-random-content', text: 'Here is the content')
      end
    end

    context 'when there is no heading or actions' do
      let(:govuk_cookie_banner_message) { described_class.new(text: text, context: view_context, **options) }

      it 'only renders the message text' do
        expect(cookie_banner_messages_element.to_html).to eq('
          <div class="govuk-cookie-banner__message govuk-width-container">
            <div class="govuk-grid-row">
              <div class="govuk-grid-column-two-thirds">
                <div class="govuk-cookie-banner__content">
                  <p class="govuk-body">These are the cookies for ouroboros</p>
                </div>
              </div>
            </div>
          </div>
        '.to_one_line)
      end
    end
  end
end
