# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/header'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::Header, '#fixtures', type: :helper do
  include described_class

  describe '.ccs_header from fixtures' do
    include_context 'and I have loaded the CCS Frontend fixture'

    let(:component_name) { 'header' }
    # Because Rails automatically adds names to buttons and the hidden attribute is a bit different
    let(:fixture_html) { fixture[:html].to_one_line.gsub('<button ', '<button name="button" ').gsub('hidden>', 'hidden="hidden">') }

    before do
      {
        service: [
          %i[serviceName name],
          %i[serviceUrl href]
        ],
        navigation: [
          %i[navigationPrimary primary_items],
          %i[navigationSecondary secondary_items],
          %i[navigationLabel label],
          %i[navigationClasses classes]
        ],
        menu_button: [
          %i[menuButtonLabel label],
        ]
      }.each do |key, attributes|
        attributes.each do |fixture_attribute, new_attribute|
          if fixture_options[fixture_attribute]
            fixture_options[key] ||= {}
            fixture_options[key][new_attribute] = fixture_options[fixture_attribute]
          end
        end
      end

      fixture_options.dig(:navigation, :primary_items)&.each do |primary_item|
        next unless primary_item[:html]

        primary_item[:text] = primary_item[:html].html_safe
        primary_item.delete(:html)
      end

      [
        'ccs-header__navigation',
        'ccs-header__navigation ccs-header__navigation--no-service-name',
        'ccs-header__navigation-primary-list',
        'ccs-header__navigation-secondary-list'
      ].each do |class_name|
        fixture_html.gsub!("class=\"#{class_name} \"", "class=\"#{class_name}\"")
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { ccs_header }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with service name'" do
      let(:fixture_name) { 'with service name' }
      let(:result) { ccs_header(service: fixture_options[:service]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with authentication options'" do
      let(:fixture_name) { 'with authentication options' }
      let(:result) { ccs_header(service_authentication_items: fixture_options[:serviceAuthentication]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with both navigation'" do
      let(:fixture_name) { 'with both navigation' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with only primary navigation'" do
      let(:fixture_name) { 'with only primary navigation' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with only secondary navigation'" do
      let(:fixture_name) { 'with only secondary navigation' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom navigation label'" do
      let(:fixture_name) { 'with custom navigation label' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom menu button label'" do
      let(:fixture_name) { 'with custom menu button label' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation], menu_button: fixture_options[:menu_button]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with service name, authentication and navigation'" do
      let(:fixture_name) { 'with service name, authentication and navigation' }
      let(:result) { ccs_header(service: fixture_options[:service], navigation: fixture_options[:navigation], service_authentication_items: fixture_options[:serviceAuthentication]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with large navigation'" do
      let(:fixture_name) { 'with large navigation' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full example from CCS website'" do
      let(:fixture_name) { 'full example from CCS website' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full width'" do
      let(:fixture_name) { 'full width' }
      let(:result) { ccs_header(container_classes: fixture_options[:containerClasses], navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'full width with navigation and service authentication'" do
      let(:fixture_name) { 'full width with navigation and service authentication' }
      let(:result) { ccs_header(container_classes: fixture_options[:containerClasses], navigation: fixture_options[:navigation], service_authentication_items: fixture_options[:serviceAuthentication]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'navigation item with html'" do
      let(:fixture_name) { 'navigation item with html' }
      let(:result) { ccs_header(service: fixture_options[:service], navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'navigation item with text without link'" do
      let(:fixture_name) { 'navigation item with text without link' }
      let(:result) { ccs_header(service: fixture_options[:service], navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { ccs_header(attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { ccs_header(classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom homepage url'" do
      let(:fixture_name) { 'custom homepage url' }
      let(:result) { ccs_header(homepage_url: fixture_options[:homepageUrl]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'navigation item with attributes'" do
      let(:fixture_name) { 'navigation item with attributes' }
      let(:result) { ccs_header(navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'navigation item with html as text'" do
      let(:fixture_name) { 'navigation item with html as text' }
      let(:result) { ccs_header(service: fixture_options[:service], navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'navigation item with html without link'" do
      let(:fixture_name) { 'navigation item with html without link' }
      let(:result) { ccs_header(service: fixture_options[:service], navigation: fixture_options[:navigation]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
