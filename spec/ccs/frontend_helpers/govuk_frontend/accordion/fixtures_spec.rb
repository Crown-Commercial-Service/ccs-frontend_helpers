# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/accordion'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Accordion, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_accordion from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'

    let(:component_name) { 'accordion' }

    before do
      fixture_options[:items].each do |accordion_item|
        %i[heading summary].each do |attribute|
          if accordion_item.dig(attribute, :html)
            accordion_item[attribute] = accordion_item[attribute][:html].html_safe
          elsif accordion_item.dig(attribute, :text)
            accordion_item[attribute] = accordion_item[attribute][:text]
          end
        end

        if accordion_item.dig(:content, :html)
          accordion_item[:content] = accordion_item[:content][:html].html_safe
        elsif accordion_item.dig(:content, :text)
          accordion_item[:text] = accordion_item[:content][:text]
          accordion_item.delete(:content)
        end
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with additional descriptions'" do
      let(:fixture_name) { 'with additional descriptions' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with long content and description'" do
      let(:fixture_name) { 'with long content and description' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with one section open'" do
      let(:fixture_name) { 'with one section open' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with all sections already open'" do
      let(:fixture_name) { 'with all sections already open' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with focusable elements inside'" do
      let(:fixture_name) { 'with focusable elements inside' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with translations'" do
      let(:fixture_name) { 'with translations' }
      let(:result) do
        govuk_accordion(
          fixture_options[:id],
          fixture_options[:items],
          hide_all_sections_text: fixture_options[:hideAllSectionsText],
          hide_section_text: fixture_options[:hideSectionText],
          hide_section_aria_label_text: fixture_options[:hideSectionAriaLabelText],
          show_all_sections_text: fixture_options[:showAllSectionsText],
          show_section_text: fixture_options[:showSectionText],
          show_section_aria_label_text: fixture_options[:showSectionAriaLabelText]
        )
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom heading level'" do
      let(:fixture_name) { 'custom heading level' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items], heading_level: fixture_options[:headingLevel]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'heading html'" do
      let(:fixture_name) { 'heading html' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with remember expanded off'" do
      let(:fixture_name) { 'with remember expanded off' }
      let(:result) { govuk_accordion(fixture_options[:id], fixture_options[:items], attributes: { data: { 'remember-expanded': fixture_options[:rememberExpanded] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
