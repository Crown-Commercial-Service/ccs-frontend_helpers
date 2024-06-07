# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/date_input'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::DateInput, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_date_input from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'date-input' }

    before do
      if fixture_options[:namePrefix]
        fixture_options[:name] = fixture_options[:namePrefix]
        fixture_options.delete(:namePrefix)
      else
        fixture_options[:name] = fixture_options[:id]
      end

      %i[id].each do |attribute|
        next unless fixture_options[attribute]

        fixture_options[:attributes] ||= {}
        fixture_options[:attributes][attribute] = fixture_options[attribute]
        fixture_options.delete(attribute)
      end

      item_names = if fixture_options[:items].present?
                     fixture_options[:items].each do |item|
                       %i[classes attributes value].each do |attribute|
                         next unless item[attribute]

                         item[:input] ||= {}
                         item[:input][attribute] = item[attribute]
                         item.delete(attribute)
                       end
                       %i[id autocomplete pattern inputmode].each do |attribute|
                         next unless item[attribute]

                         (item[:input] ||= {})[:attributes] ||= {}
                         item[:input][:attributes][attribute] = item[attribute]
                         item.delete(attribute)
                       end

                       item[:input][:classes]&.sub!(' govuk-input--error', '') if item.dig(:input, :classes)
                     end

                     fixture_options[:items].pluck(:name)
                   else
                     %i[day month year]
                   end

      item_names.each do |item_name|
        fixture_html.sub!('<div class="govuk-form-group', "<div id=\"#{fixture_options[:name]}_#{item_name}-form-group\" class=\"govuk-form-group")

        fixture_html.sub!("name=\"#{item_name}\"", "name=\"#{fixture_options[:name]}_#{item_name}\"")
        fixture_html.gsub!("#{fixture_options[:name]}-#{item_name}", "#{fixture_options[:name]}_#{item_name}")
      end

      fixture_html.gsub!(' govuk-date-input__input "', ' govuk-date-input__input"')

      if fixture_options[:fieldset]
        if fixture_options[:fieldset][:legend][:html]
          fixture_options[:fieldset][:legend][:text] = fixture_options[:fieldset][:legend][:html].html_safe
          fixture_options[:fieldset][:legend].delete(:html)
        end
        if fixture_options[:fieldset][:describedBy]
          fixture_options[:fieldset][:attributes] ||= {}
          fixture_options[:fieldset][:attributes] = { aria: { describedby: fixture_options[:fieldset][:describedBy] } }
          fixture_options[:fieldset].delete(:describedBy)
        end
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_date_input(fixture_options[:name], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'complete question'" do
      let(:fixture_name) { 'complete question' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'day and month'" do
      let(:fixture_name) { 'day and month' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'month and year'" do
      let(:fixture_name) { 'month and year' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with errors only'" do
      let(:fixture_name) { 'with errors only' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with errors and hint'" do
      let(:fixture_name) { 'with errors and hint' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with default items'" do
      let(:fixture_name) { 'with default items' }
      let(:result) { govuk_date_input(fixture_options[:name], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with optional form-group classes'" do
      let(:fixture_name) { 'with optional form-group classes' }
      let(:result) { govuk_date_input(fixture_options[:name], form_group: fixture_options[:formGroup], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with autocomplete values'" do
      let(:fixture_name) { 'with autocomplete values' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      before do
        fixture_html.gsub!("#{fixture_options[:attributes][:id]}-hint", "#{fixture_options[:name]}-hint")
        %i[day month year].each { |item_name| fixture_html.gsub!("#{fixture_options[:attributes][:id]}-#{item_name}", "#{fixture_options[:name]}_#{item_name}") }
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with input attributes'" do
      let(:fixture_name) { 'with input attributes' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_date_input(fixture_options[:name], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_date_input(fixture_options[:name], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with empty items'" do
      let(:fixture_name) { 'with empty items' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom pattern'" do
      let(:fixture_name) { 'custom pattern' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom inputmode'" do
      let(:fixture_name) { 'custom inputmode' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with nested name'" do
      let(:fixture_name) { 'with nested name' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      before do
        [
          %i[day dd],
          %i[month mm],
          %i[year yyyy]
        ].each do |item_code, item_name|
          old_id = "\"#{fixture_options[:name]}_#{item_code}[#{item_name}]\""
          new_id = "\"#{fixture_options[:name]}_#{item_code}_#{item_name}\""

          fixture_html.gsub!("for=#{old_id}", "for=#{new_id}")
          fixture_html.gsub!("id=#{old_id}", "id=#{new_id}")
        end
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with id on items'" do
      let(:fixture_name) { 'with id on items' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'suffixed id'" do
      let(:fixture_name) { 'suffixed id' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with values'" do
      let(:fixture_name) { 'with values' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint and describedBy'" do
      let(:fixture_name) { 'with hint and describedBy' }
      let(:result) { govuk_date_input(fixture_options[:name], fieldset: fixture_options[:fieldset], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error and describedBy'" do
      let(:fixture_name) { 'with error and describedBy' }
      let(:result) { govuk_date_input(fixture_options[:name], fieldset: fixture_options[:fieldset], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes]) }

      before do
        fixture_html.gsub!('govuk-input--width-2', 'govuk-input--width-2 govuk-input--error')
        fixture_html.gsub!('govuk-input--width-4', 'govuk-input--width-4 govuk-input--error')
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'fieldset html'" do
      let(:fixture_name) { 'fieldset html' }
      let(:result) { govuk_date_input(fixture_options[:name], fieldset: fixture_options[:fieldset], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'items with classes'" do
      let(:fixture_name) { 'items with classes' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'items without classes'" do
      let(:fixture_name) { 'items without classes' }
      let(:result) { govuk_date_input(fixture_options[:name], date_items: fixture_options[:items], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
