# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/cookie_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::CookieBanner, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_cookie_banner from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'cookie-banner' }
    let(:fixture_html) { fixture[:html].to_one_line.gsub('data-nosnippet ', 'data-nosnippet="true" ') }

    before do
      fixture_options[:messages].each do |message|
        if message[:headingText]
          message[:heading_text] = message[:headingText]
          message.delete(:headingText)
        end
        [
          %i[headingHtml heading_text],
          %i[html content],
        ].each do |attribute, new_attribute|
          next unless message[attribute]

          message[new_attribute] = message[attribute].html_safe
          message.delete(attribute)
        end
        %i[role hidden].each do |attribute|
          next unless message[attribute]

          message[:attributes] ||= {}
          message[:attributes][attribute] = message[attribute]
          message.delete(attribute)
        end
        message[:actions]&.each do |action|
          %i[name value type].each do |attribute|
            next unless action[attribute]

            action[:attributes] ||= {}
            action[:attributes][attribute] = action[attribute].to_sym
            action.delete(attribute)
          end
        end
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'accepted confirmation banner'" do
      let(:fixture_name) { 'accepted confirmation banner' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        # Rails renders button tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'rejected confirmation banner'" do
      let(:fixture_name) { 'rejected confirmation banner' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        # Rails renders button tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'client-side implementation'" do
      let(:fixture_name) { 'client-side implementation' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        # Rails renders button tags with name by default
        expect(result).to eq_html(fixture_html.gsub('<button type=', '<button name="button" type=').gsub('hidden>', 'hidden="hidden">'))
      end
    end

    context "when the fixture is 'with html'" do
      let(:fixture_name) { 'with html' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'heading html'" do
      let(:fixture_name) { 'heading html' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'heading html as text'" do
      let(:fixture_name) { 'heading html as text' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'html'" do
      let(:fixture_name) { 'html' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('app-my-class govuk-width-container', 'govuk-width-container app-my-class'))
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom aria label'" do
      let(:fixture_name) { 'custom aria label' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages], attributes: { aria: { label: fixture_options[:ariaLabel] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'hidden'" do
      let(:fixture_name) { 'hidden' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('hidden>', 'hidden="hidden">'))
      end
    end

    context "when the fixture is 'hidden false'" do
      let(:fixture_name) { 'hidden false' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'default action'" do
      let(:fixture_name) { 'default action' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'link'" do
      let(:fixture_name) { 'link' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'link with false button options'" do
      let(:fixture_name) { 'link with false button options' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        # Button attributes are valid on a tags even if they do nothing
        expect(result).to eq_html(fixture_html.gsub('<a ', '<a name="link" value="cookies"'))
      end
    end

    context "when the fixture is 'link as a button'" do
      let(:fixture_name) { 'link as a button' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('<a ', '<a type="button"'))
      end
    end

    context "when the fixture is 'type'" do
      let(:fixture_name) { 'type' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'button classes'" do
      let(:fixture_name) { 'button classes' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'button attributes'" do
      let(:fixture_name) { 'button attributes' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('<button ', '<button name="button" '))
      end
    end

    context "when the fixture is 'link classes'" do
      let(:fixture_name) { 'link classes' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'link attributes'" do
      let(:fixture_name) { 'link attributes' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full banner hidden'" do
      let(:fixture_name) { 'full banner hidden' }
      let(:result) { govuk_cookie_banner(fixture_options[:messages], classes: fixture_options[:classes], attributes: { hidden: fixture_options[:hidden], data: { 'hide-cookie-banner': fixture_options[:attributes][:'data-hide-cookie-banner'] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('<button type=', '<button name="button" type=').gsub('hidden ', 'hidden="hidden" '))
      end
    end
  end
end
