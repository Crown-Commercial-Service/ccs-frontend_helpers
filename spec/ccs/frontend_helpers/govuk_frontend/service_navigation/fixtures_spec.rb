# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/service_navigation'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ServiceNavigation, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_service_navigation from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'service-navigation' }
    # Because Rails automatically adds names to buttons and the hidden attribute is a bit different
    let(:fixture_html) { fixture[:html].to_one_line.gsub('<button ', '<button name="button" ').gsub('hidden>', 'hidden="hidden">') }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with navigation with a current item'" do
      let(:fixture_name) { 'with navigation with a current item' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with navigation with an active item'" do
      let(:fixture_name) { 'with navigation with an active item' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with large navigation'" do
      let(:fixture_name) { 'with large navigation' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with HTML navigation items'" do
      let(:fixture_name) { 'with HTML navigation items' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation].map { |navigation_item| navigation_item.merge({ text: navigation_item[:html].html_safe }) } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with non-link navigation items'" do
      let(:fixture_name) { 'with non-link navigation items' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation].map { |navigation_item| navigation_item.merge({ text: navigation_item[:text] || navigation_item[:html].html_safe }) } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with service name'" do
      let(:fixture_name) { 'with service name' }
      let(:result) { govuk_service_navigation(service: { name: fixture_options[:serviceName] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with service link'" do
      let(:fixture_name) { 'with service link' }
      let(:result) { govuk_service_navigation(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with long service name'" do
      let(:fixture_name) { 'with long service name' }
      let(:result) { govuk_service_navigation(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with service name and navigation'" do
      let(:fixture_name) { 'with service name and navigation' }
      let(:result) { govuk_service_navigation(service: { name: fixture_options[:serviceName], href: fixture_options[:serviceUrl] }, navigation: { items: fixture_options[:navigation] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with no options set'" do
      let(:fixture_name) { 'with no options set' }
      let(:result) { govuk_service_navigation }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_service_navigation(service: { name: fixture_options[:serviceName] }, attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_service_navigation(service: { name: fixture_options[:serviceName] }, classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom aria-label'" do
      let(:fixture_name) { 'with custom aria-label' }
      let(:result) { govuk_service_navigation(service: { name: fixture_options[:serviceName] }, attributes: { aria: { label: fixture_options[:ariaLabel] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation toggle text'" do
      let(:fixture_name) { 'with custom navigation toggle text' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation] }, menu_button: { text: fixture_options[:menuButtonText] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation toggle label'" do
      let(:fixture_name) { 'with custom navigation toggle label' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation] }, menu_button: { label: fixture_options[:menuButtonLabel] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with identical navigation toggle text and label'" do
      let(:fixture_name) { 'with identical navigation toggle text and label' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation] }, menu_button: { text: fixture_options[:menuButtonText], label: fixture_options[:menuButtonLabel] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation label'" do
      let(:fixture_name) { 'with custom navigation label' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation], label: fixture_options[:navigationLabel] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation toggle text and navigation label'" do
      let(:fixture_name) { 'with custom navigation toggle text and navigation label' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation], label: fixture_options[:navigationLabel] }, menu_button: { text: fixture_options[:menuButtonText] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation classes'" do
      let(:fixture_name) { 'with custom navigation classes' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation], classes: fixture_options[:navigationClasses] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation ID'" do
      let(:fixture_name) { 'with custom navigation ID' }
      let(:result) { govuk_service_navigation(navigation: { items: fixture_options[:navigation], id: fixture_options[:navigationId] }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
