# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/input'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Input, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_input from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'input' }

    before do
      fixture_options[:name] ||= fixture_options[:id]

      %i[id autocomplete pattern spellcheck type inputmode autocapitalize disabled].each do |attribute|
        next if fixture_options[attribute].nil?

        fixture_options[:attributes] ||= {}
        fixture_options[:attributes][attribute] = fixture_options[attribute]
        fixture_options.delete(attribute)
      end

      %i[prefix suffix label].each do |fix|
        next unless fixture_options.dig(fix, :html)

        fixture_options[fix][:text] = fixture_options[fix][:html].html_safe
        fixture_options[fix].delete(:html)
      end

      fixture_html.gsub!("#{fixture_options[:attributes][:id]}-hint", "#{fixture_options[:name]}-hint") if fixture_options[:hint]
      fixture_html.gsub!("#{fixture_options[:attributes][:id]}-error", "#{fixture_options[:name]}-error") if fixture_options[:errorMessage]
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint text'" do
      let(:fixture_name) { 'with hint text' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message'" do
      let(:fixture_name) { 'with error message' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with width-2 class'" do
      let(:fixture_name) { 'with width-2 class' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with width-3 class'" do
      let(:fixture_name) { 'with width-3 class' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with width-4 class'" do
      let(:fixture_name) { 'with width-4 class' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with width-5 class'" do
      let(:fixture_name) { 'with width-5 class' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with width-10 class'" do
      let(:fixture_name) { 'with width-10 class' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with width-20 class'" do
      let(:fixture_name) { 'with width-20 class' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with width-30 class'" do
      let(:fixture_name) { 'with width-30 class' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with label as page heading'" do
      let(:fixture_name) { 'with label as page heading' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      before do
        fixture_options[:label][:is_page_heading] = fixture_options[:label][:isPageHeading]
        fixture_options[:label].delete(:isPageHeading)
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with optional form-group classes'" do
      let(:fixture_name) { 'with optional form-group classes' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], form_group: fixture_options[:formGroup], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with autocomplete attribute'" do
      let(:fixture_name) { 'with autocomplete attribute' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'disabled'" do
      let(:fixture_name) { 'disabled' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html.gsub('name=""', 'name="disabled-input"'))
      end
    end

    context "when the fixture is 'with pattern attribute'" do
      let(:fixture_name) { 'with pattern attribute' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with spellcheck enabled'" do
      let(:fixture_name) { 'with spellcheck enabled' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with spellcheck disabled'" do
      let(:fixture_name) { 'with spellcheck disabled' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with autocapitalize turned off'" do
      let(:fixture_name) { 'with autocapitalize turned off' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix'" do
      let(:fixture_name) { 'with prefix' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with suffix'" do
      let(:fixture_name) { 'with suffix' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], suffix: fixture_options[:suffix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix and suffix'" do
      let(:fixture_name) { 'with prefix and suffix' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], suffix: fixture_options[:suffix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix and long suffix'" do
      let(:fixture_name) { 'with prefix and long suffix' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], suffix: fixture_options[:suffix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix and suffix and error'" do
      let(:fixture_name) { 'with prefix and suffix and error' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], suffix: fixture_options[:suffix], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix and suffix and width modifier'" do
      let(:fixture_name) { 'with prefix and suffix and width modifier' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], suffix: fixture_options[:suffix], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with extra letter spacing'" do
      let(:fixture_name) { 'with extra letter spacing' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes], value: fixture_options[:value], attributes: fixture_options[:attributes]) }

      before { fixture_html.sub!('name=""', "name=\"#{fixture_options[:name]}\"") }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'custom type'" do
      let(:fixture_name) { 'custom type' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'value'" do
      let(:fixture_name) { 'value' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], value: fixture_options[:value], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'zero value'" do
      let(:fixture_name) { 'zero value' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], value: fixture_options[:value], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with describedBy'" do
      let(:fixture_name) { 'with describedBy' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes].merge({ aria: { describedby: fixture_options[:describedBy] } })) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'hint with describedBy'" do
      let(:fixture_name) { 'hint with describedBy' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], attributes: fixture_options[:attributes].merge({ aria: { describedby: fixture_options[:describedBy] } })) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error with describedBy'" do
      let(:fixture_name) { 'error with describedBy' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes].merge({ aria: { describedby: fixture_options[:describedBy] } })) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error and hint'" do
      let(:fixture_name) { 'with error and hint' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error, hint and describedBy'" do
      let(:fixture_name) { 'with error, hint and describedBy' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], attributes: fixture_options[:attributes].merge({ aria: { describedby: fixture_options[:describedBy] } })) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'inputmode'" do
      let(:fixture_name) { 'inputmode' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix with html as text'" do
      let(:fixture_name) { 'with prefix with html as text' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix with html'" do
      let(:fixture_name) { 'with prefix with html' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix with classes'" do
      let(:fixture_name) { 'with prefix with classes' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with prefix with attributes'" do
      let(:fixture_name) { 'with prefix with attributes' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with suffix with html as text'" do
      let(:fixture_name) { 'with suffix with html as text' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], suffix: fixture_options[:suffix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with suffix with html'" do
      let(:fixture_name) { 'with suffix with html' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], suffix: fixture_options[:suffix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with suffix with classes'" do
      let(:fixture_name) { 'with suffix with classes' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], suffix: fixture_options[:suffix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with suffix with attributes'" do
      let(:fixture_name) { 'with suffix with attributes' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], suffix: fixture_options[:suffix], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with customised input wrapper'" do
      let(:fixture_name) { 'with customised input wrapper' }
      let(:result) { govuk_input(fixture_options[:name], label: fixture_options[:label], prefix: fixture_options[:prefix], suffix: fixture_options[:suffix], input_wrapper: fixture_options[:inputWrapper], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
