# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/select'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Select, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_select from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'select' }

    before do
      fixture_options[:items]&.each do |item|
        %i[selected disabled].each do |attribute|
          next unless item[attribute]

          item[:attributes] ||= {}
          item[:attributes][attribute] = item[attribute]
          item.delete(attribute)
        end
      end
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with no items'" do
      let(:fixture_name) { 'with no items' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with selected value'" do
      let(:fixture_name) { 'with selected value' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], selected: fixture_options[:value]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint text and error message'" do
      let(:fixture_name) { 'with hint text and error message' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with label as page heading'" do
      let(:fixture_name) { 'with label as page heading' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label]) }

      before do
        fixture_options[:label][:is_page_heading] = fixture_options[:label][:isPageHeading]
        fixture_options[:label].delete(:isPageHeading)
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with full width override'" do
      let(:fixture_name) { 'with full width override' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with optional form-group classes'" do
      let(:fixture_name) { 'with optional form-group classes' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], form_group: fixture_options[:formGroup], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with describedBy'" do
      let(:fixture_name) { 'with describedBy' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes on items'" do
      let(:fixture_name) { 'attributes on items' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], selected: fixture_options[:value]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'hint'" do
      let(:fixture_name) { 'hint' }
      let(:result) { govuk_select(fixture_options[:name], [], label: fixture_options[:label], hint: fixture_options[:hint]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'hint and describedBy'" do
      let(:fixture_name) { 'hint and describedBy' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], hint: fixture_options[:hint], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error'" do
      let(:fixture_name) { 'error' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error and describedBy'" do
      let(:fixture_name) { 'error and describedBy' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'without values'" do
      let(:fixture_name) { 'without values' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        # Rails needs the value for the option
        fixture_options[:items].each do |item|
          fixture_html.gsub!(">#{item[:text]}</option>", " value=\"#{item[:text]}\">#{item[:text]}</option>")
        end
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'without values with selected value'" do
      let(:fixture_name) { 'without values with selected value' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label], selected: fixture_options[:value]) }

      it 'has HTML matching the fixture' do
        # Rails needs the value for the option
        fixture_options[:items].each do |item|
          fixture_html.gsub!(">#{item[:text]}</option>", " value=\"#{item[:text]}\">#{item[:text]}</option>")
        end
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with falsey values'" do
      let(:fixture_name) { 'with falsey values' }
      let(:result) { govuk_select(fixture_options[:name], fixture_options[:items], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
