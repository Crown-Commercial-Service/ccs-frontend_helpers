# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/dashboard_section'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::DashboardSection, '#fixtures', type: :helper do
  include described_class

  describe '.ccs_dashboard_section from fixtures' do
    include_context 'and I have loaded the CCS Frontend fixture'

    let(:component_name) { 'dashboard-section' }

    before do
      fixture_options[:panels].each do |dashboard_section_panel|
        %i[title description].each do |attribute|
          if dashboard_section_panel[:"#{attribute}Text"]
            dashboard_section_panel[attribute] = dashboard_section_panel[:"#{attribute}Text"]
            dashboard_section_panel.delete(:"#{attribute}Text")
          end
        end
      end

      [
        'ccs-dashboard-section',
        'ccs-dashboard-section__panel govuk-grid-column-one-third',
        'ccs-dashboard-section__panel govuk-grid-column-two-thirds',
        'ccs-dashboard-section__panel govuk-grid-column-one-half',
      ].each do |class_name|
        fixture_html.gsub!("class=\"#{class_name} \"", "class=\"#{class_name}\"")
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with title text'" do
      let(:fixture_name) { 'with title text' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels], fixture_options[:titleText]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with one long panel'" do
      let(:fixture_name) { 'with one long panel' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with dashboard width two-thirds'" do
      let(:fixture_name) { 'with dashboard width two-thirds' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels], width: fixture_options[:width]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with a panel width two-thirds'" do
      let(:fixture_name) { 'with a panel width two-thirds' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with panel widths one-half'" do
      let(:fixture_name) { 'with panel widths one-half' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'panel item with attributes'" do
      let(:fixture_name) { 'panel item with attributes' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'panel item with classes'" do
      let(:fixture_name) { 'panel item with classes' }
      let(:result) { ccs_dashboard_section(fixture_options[:panels]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html.gsub('govuk-grid-column-one-third app-dashboard-section-panel--custom-modifier', 'app-dashboard-section-panel--custom-modifier govuk-grid-column-one-third'))
      end
    end
  end
end
