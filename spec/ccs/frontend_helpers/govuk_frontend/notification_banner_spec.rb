# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/notification_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::NotificationBanner, type: :helper do
  include described_class

  let(:notification_banner_element) { Capybara::Node::Simple.new(result).find('.govuk-notification-banner') }

  describe '.govuk_notification_banner' do
    let(:result) { govuk_notification_banner(text, success_banner, **options) }
    let(:text) { 'You have defeated Mobius' }
    let(:success_banner) { false }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-notification-banner" data-module="govuk-notification-banner" role="region" aria-labelledby="govuk-notification-banner-title">
          <div class="govuk-notification-banner__header">
            <h2 class="govuk-notification-banner__title" id="govuk-notification-banner-title">
              Important
            </h2>
          </div>
          <div class="govuk-notification-banner__content">
            <p class="govuk-notification-banner__heading">
              You have defeated Mobius
            </p>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the heading text' do
        expect(notification_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_notification_banner(text, success_banner) }

      it 'correctly formats the HTML with the heading text' do
        expect(notification_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when I pass in content' do
      let(:result) do
        govuk_notification_banner(text, success_banner, **options) do
          content
        end
      end

      let(:content) do
        concat(tag.h3('You have defeated Mobius', class: 'govuk-notification-banner__heading'))
        concat(tag.p(class: 'govuk-body') do
          concat('Contact ')
          concat(tag.a('melia.antiquq@alchamoth.com', class: 'govuk-notification-banner__link', href: '#'))
          concat(' for your next steps')
        end)
      end

      it 'renders the content and ignores the title text' do
        expect(notification_banner_element).to have_css('.govuk-notification-banner__content > h3.govuk-notification-banner__heading', text: 'You have defeated Mobius')
        expect(notification_banner_element).to have_css('.govuk-notification-banner__content > p.govuk-body', text: 'Contact melia.antiquq@alchamoth.com for your next steps')
      end
    end
  end
end
