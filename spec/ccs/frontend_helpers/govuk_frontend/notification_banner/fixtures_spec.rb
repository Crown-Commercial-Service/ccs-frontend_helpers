# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/notification_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::NotificationBanner, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_notification_banner from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'notification-banner' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_notification_banner(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with text as html'" do
      let(:fixture_name) { 'with text as html' }
      let(:result) do
        govuk_notification_banner do
          fixture_options[:html].html_safe
        end
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with type as success'" do
      let(:fixture_name) { 'with type as success' }
      let(:result) { govuk_notification_banner(fixture_options[:text], true) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with long heading'" do
      let(:fixture_name) { 'with long heading' }
      let(:result) { govuk_notification_banner(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with lots of content'" do
      let(:fixture_name) { 'with lots of content' }
      let(:result) do
        govuk_notification_banner do
          fixture_options[:html].html_safe
        end
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'auto-focus disabled, with type as success'" do
      let(:fixture_name) { 'auto-focus disabled, with type as success' }
      let(:result) { govuk_notification_banner(fixture_options[:text], true, attributes: { data: { 'disable-auto-focus': fixture_options[:disableAutoFocus] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'auto-focus explicitly enabled, with type as success'" do
      let(:fixture_name) { 'auto-focus explicitly enabled, with type as success' }
      let(:result) { govuk_notification_banner(fixture_options[:text], true, attributes: { data: { 'disable-auto-focus': fixture_options[:disableAutoFocus] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'role=alert overridden to role=region, with type as success'" do
      let(:fixture_name) { 'role=alert overridden to role=region, with type as success' }
      let(:result) { govuk_notification_banner(fixture_options[:text], true, attributes: { role: fixture_options[:role] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom tabindex'" do
      let(:fixture_name) { 'custom tabindex' }
      let(:result) { govuk_notification_banner(fixture_options[:text], true, attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom title'" do
      let(:fixture_name) { 'custom title' }
      let(:result) { govuk_notification_banner(fixture_options[:text], title_text: fixture_options[:titleText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'title as html'" do
      let(:fixture_name) { 'title as html' }
      let(:result) { govuk_notification_banner(fixture_options[:text], title_text: fixture_options[:titleHtml].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'title html as text'" do
      let(:fixture_name) { 'title html as text' }
      let(:result) { govuk_notification_banner(fixture_options[:text], title_text: fixture_options[:titleText]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom title heading level'" do
      let(:fixture_name) { 'custom title heading level' }
      let(:result) { govuk_notification_banner(fixture_options[:text], heading_level: fixture_options[:titleHeadingLevel]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom title id'" do
      let(:fixture_name) { 'custom title id' }
      let(:result) { govuk_notification_banner(fixture_options[:text], title_id: fixture_options[:titleId]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom title id with type as success'" do
      let(:fixture_name) { 'custom title id with type as success' }
      let(:result) { govuk_notification_banner(fixture_options[:text], true, title_id: fixture_options[:titleId]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom text'" do
      let(:fixture_name) { 'custom text' }
      let(:result) { govuk_notification_banner(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html as text'" do
      let(:fixture_name) { 'html as text' }
      let(:result) { govuk_notification_banner(fixture_options[:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom role'" do
      let(:fixture_name) { 'custom role' }
      let(:result) { govuk_notification_banner(fixture_options[:text], attributes: { role: fixture_options[:role] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_notification_banner(fixture_options[:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_notification_banner(fixture_options[:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
