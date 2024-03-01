# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/header'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Header, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_header from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'header' }
    let(:fixture_html) { fixture[:html].to_one_line.gsub('svgfocusable', 'svg focusable') }
    # Because Rails automatically adds names to buttons and the hidden attribute is a bit different
    let(:fixture_with_navigation_html) { fixture_html.gsub('<button ', '<button name="button" ').gsub('hidden>', 'hidden="hidden">') }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_header }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with St Edward's crown'" do
      let(:fixture_name) { "with St Edward's crown" }
      let(:result) { govuk_header(use_tudor_crown: false) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with service name'" do
      let(:fixture_name) { 'with service name' }
      let(:result) { govuk_header(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with service name but no service url'" do
      let(:fixture_name) { 'with service name but no service url' }
      let(:result) { govuk_header(service: { name: fixture_options[:serviceName] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with navigation'" do
      let(:fixture_name) { 'with navigation' }
      let(:result) { govuk_header(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'with custom navigation label'" do
      let(:fixture_name) { 'with custom navigation label' }
      let(:result) { govuk_header(navigation: { label: fixture_options[:navigationLabel], items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'with custom menu button text'" do
      let(:fixture_name) { 'with custom menu button text' }
      let(:result) { govuk_header(navigation: { items: fixture_options[:navigation] }, menu_button: { text: fixture_options[:menuButtonText] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'with custom menu button label'" do
      let(:fixture_name) { 'with custom menu button label' }
      let(:result) { govuk_header(navigation: { items: fixture_options[:navigation] }, menu_button: { label: fixture_options[:menuButtonLabel] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'with service name and navigation'" do
      let(:fixture_name) { 'with service name and navigation' }
      let(:result) { govuk_header(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }, navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'with large navigation'" do
      let(:fixture_name) { 'with large navigation' }
      let(:result) { govuk_header(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'with product name'" do
      let(:fixture_name) { 'with product name' }
      let(:result) { govuk_header(product_name: fixture_options[:productName]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full width'" do
      let(:fixture_name) { 'full width' }
      let(:result) { govuk_header(product_name: fixture_options[:productName], container_classes: fixture_options[:containerClasses]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full width with navigation'" do
      let(:fixture_name) { 'full width with navigation' }
      let(:result) { govuk_header(product_name: fixture_options[:productName], container_classes: fixture_options[:containerClasses], navigation: { items: fixture_options[:navigation], classes: fixture_options[:navigationClasses] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'navigation item with html'" do
      let(:fixture_name) { 'navigation item with html' }
      let(:result) { govuk_header(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }, navigation: { items: fixture_options[:navigation].map { |navigation_item| navigation_item.merge({ text: navigation_item[:html].html_safe }) } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'navigation item with text without link'" do
      let(:fixture_name) { 'navigation item with text without link' }
      let(:result) { govuk_header(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }, navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_header(attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_header(classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom homepage url'" do
      let(:fixture_name) { 'custom homepage url' }
      let(:result) { govuk_header(homepage_url: fixture_options[:homepageUrl]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'navigation item with attributes'" do
      let(:fixture_name) { 'navigation item with attributes' }
      let(:result) { govuk_header(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'navigation item with html as text'" do
      let(:fixture_name) { 'navigation item with html as text' }
      let(:result) { govuk_header(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }, navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'navigation item with html without link'" do
      let(:fixture_name) { 'navigation item with html without link' }
      let(:result) { govuk_header(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }, navigation: { items: fixture_options[:navigation].map { |navigation_item| navigation_item.merge({ text: navigation_item[:html].html_safe }) } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'with custom navigation label and custom menu button text'" do
      let(:fixture_name) { 'with custom navigation label and custom menu button text' }
      let(:result) { govuk_header(navigation: { label: fixture_options[:navigationLabel], items: fixture_options[:navigation] }, menu_button: { text: fixture_options[:menuButtonText] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end

    context "when the fixture is 'empty navigation array'" do
      let(:fixture_name) { 'empty navigation array' }
      let(:result) { govuk_header(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_with_navigation_html)
      end
    end
  end
end
