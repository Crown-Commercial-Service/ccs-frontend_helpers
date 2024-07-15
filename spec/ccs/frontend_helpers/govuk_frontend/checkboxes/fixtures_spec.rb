# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/checkboxes'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Checkboxes, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_checkboxes from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'checkboxes' }

    before do
      fixture_options[:items]&.each&.with_index(1) do |item, index|
        if item[:value]
          search_text = format(index == 1 ? '%<id>s' : "%<id>s-#{index}", id: fixture_options[:idPrefix] || fixture_options[:name])

          fixture_html.sub!("id=\"#{search_text}\"", "id=\"#{fixture_options[:name]}_#{item[:value]}\"")
          fixture_html.sub!("for=\"#{search_text}\"", "for=\"#{fixture_options[:name]}_#{item[:value]}\"")
        end

        %i[id disabled name].each do |attribute|
          next unless item[attribute]

          item[:attributes] ||= {}
          item[:attributes][attribute] = item[attribute]
          item.delete(attribute)
        end

        if item[:behaviour]
          (item[:attributes] ||= {})[:data] ||= {}
          item[:attributes][:data][:behaviour] = item[:behaviour]
          item.delete(:behaviour)
        end

        if item[:hint]
          search_text = item.dig(:attributes, :id) || ((fixture_options[:idPrefix] || fixture_options[:name]) + (index > 1 ? "-#{index}" : ''))

          fixture_html.gsub!("#{search_text}-item-hint", "#{fixture_options[:name]}_#{item[:value]}-item-hint")
        end

        if item[:text]
          item[:label] ||= {}
          item[:label][:text] = item[:text]
          item.delete(:text)
        end

        if item[:html]
          item[:label] ||= {}
          item[:label][:text] = item[:html].html_safe
          item.delete(:html)
        end

        if item[:conditional]
          if item[:conditional][:html]
            item[:conditional] = { content: item[:conditional][:html].html_safe }
            item[:conditional].delete(:html)
          end

          search_text = format(index == 1 ? 'conditional-%<id>s' : "conditional-%<id>s-#{index}", id: fixture_options[:idPrefix] || fixture_options[:name])

          fixture_html.gsub!("\"#{search_text}\"", "\"conditional-#{fixture_options[:name]}_#{item[:value]}\"")
        end
      end
      if fixture_options[:fieldset]
        if fixture_options[:fieldset][:legend][:html]
          fixture_options[:fieldset][:legend][:text] = fixture_options[:fieldset][:legend][:html].html_safe
          fixture_options[:fieldset][:legend].delete(:html)
        end
        if fixture_options[:fieldset][:legend][:isPageHeading]
          fixture_options[:fieldset][:legend][:is_page_heading] = fixture_options[:fieldset][:legend][:isPageHeading]
          fixture_options[:fieldset][:legend].delete(:isPageHeading)
        end
        if fixture_options[:fieldset][:describedBy]
          fixture_options[:fieldset][:attributes] ||= {}
          fixture_options[:fieldset][:attributes] = { aria: { describedby: fixture_options[:fieldset][:describedBy] } }
          fixture_options[:fieldset].delete(:describedBy)
        end
      end

      fixture_html.gsub!("name=\"#{fixture_options[:name]}\"", "name=\"#{fixture_options[:name]}[]\"")
      fixture_html.gsub!("\"#{fixture_options[:idPrefix]}-error\"", "\"#{fixture_options[:name]}-error\"") if fixture_options[:errorMessage] && fixture_options[:idPrefix]
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with pre-checked values'" do
      let(:fixture_name) { 'with pre-checked values' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], values: fixture_options[:values]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with divider and None'" do
      let(:fixture_name) { 'with divider and None' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with divider, None and conditional items'" do
      let(:fixture_name) { 'with divider, None and conditional items' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with id and name'" do
      let(:fixture_name) { 'with id and name' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hints on items'" do
      let(:fixture_name) { 'with hints on items' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with disabled item'" do
      let(:fixture_name) { 'with disabled item' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with with legend as a page heading'" do
      let(:fixture_name) { 'with legend as a page heading' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with a medium legend'" do
      let(:fixture_name) { 'with a medium legend' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'without fieldset'" do
      let(:fixture_name) { 'without fieldset' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with single option set 'aria-describedby' on input'" do
      let(:fixture_name) { "with single option set 'aria-describedby' on input" }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with single option (and hint) set 'aria-describedby' on input" do
      let(:fixture_name) { "with single option (and hint) set 'aria-describedby' on input" }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with fieldset and error message'" do
      let(:fixture_name) { 'with fieldset and error message' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message'" do
      let(:fixture_name) { 'with error message' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message and hints on items'" do
      let(:fixture_name) { 'with error message and hints on items' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with very long option text'" do
      let(:fixture_name) { 'with very long option text' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with conditional items'" do
      let(:fixture_name) { 'with conditional items' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with conditional items with special characters'" do
      let(:fixture_name) { 'with conditional items with special characters' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with conditional item checked'" do
      let(:fixture_name) { 'with conditional item checked' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with optional form-group classes showing group error'" do
      let(:fixture_name) { 'with optional form-group classes showing group error' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], form_group: fixture_options[:formGroup], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'small'" do
      let(:fixture_name) { 'small' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'small with long text'" do
      let(:fixture_name) { 'small with long text' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'small with error'" do
      let(:fixture_name) { 'small with error' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'small with hint'" do
      let(:fixture_name) { 'small with hint' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'small with disabled'" do
      let(:fixture_name) { 'small with disabled' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'small with conditional reveal'" do
      let(:fixture_name) { 'small with conditional reveal' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'small with divider and None'" do
      let(:fixture_name) { 'small with divider and None' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with idPrefix'" do
      let(:fixture_name) { 'with idPrefix' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with fieldset describedBy'" do
      let(:fixture_name) { 'with fieldset describedBy' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], hint: fixture_options[:hint], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with checked item'" do
      let(:fixture_name) { 'with checked item' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'items with attributes'" do
      let(:fixture_name) { 'items with attributes' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'empty conditional'" do
      let(:fixture_name) { 'empty conditional' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with label classes'" do
      let(:fixture_name) { 'with label classes' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'multiple hints'" do
      let(:fixture_name) { 'multiple hints' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], hint: fixture_options[:hint]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message and hint'" do
      let(:fixture_name) { 'with error message and hint' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error, hint and fieldset describedBy'" do
      let(:fixture_name) { 'with error, hint and fieldset describedBy' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'label with attributes'" do
      let(:fixture_name) { 'label with attributes' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'fieldset params'" do
      let(:fixture_name) { 'fieldset params' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'fieldset html params'" do
      let(:fixture_name) { 'fieldset html params' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with single option set 'aria-describedby' on input, and describedBy'" do
      let(:fixture_name) { "with single option set 'aria-describedby' on input, and describedBy" }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], error_message: fixture_options[:errorMessage][:text]) }

      before do
        fixture_options[:items].each do |item|
          item[:attributes] = { aria: { describedby: fixture_options[:describedBy] } }
        end
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with single option (and hint) set 'aria-describedby' on input, and describedBy'" do
      let(:fixture_name) { "with single option (and hint) set 'aria-describedby' on input, and describedBy" }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], error_message: fixture_options[:errorMessage][:text]) }

      before do
        fixture_options[:items].each do |item|
          item[:attributes] = { aria: { describedby: fixture_options[:describedBy] } }
        end
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error and idPrefix'" do
      let(:fixture_name) { 'with error and idPrefix' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message and fieldset describedBy'" do
      let(:fixture_name) { 'with error message and fieldset describedBy' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'textarea in conditional'" do
      let(:fixture_name) { 'textarea in conditional' }
      let(:result) { govuk_checkboxes(fixture_options[:name], fixture_options[:items], fieldset: fixture_options[:fieldset]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
