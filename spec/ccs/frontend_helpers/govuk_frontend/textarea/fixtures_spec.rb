# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/textarea'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Textarea, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_textarea from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'textarea' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint'" do
      let(:fixture_name) { 'with hint' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message'" do
      let(:fixture_name) { 'with error message' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with default value'" do
      let(:fixture_name) { 'with default value' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], content: fixture_options[:value], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with custom rows'" do
      let(:fixture_name) { 'with custom rows' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], rows: fixture_options[:rows], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with label as page heading'" do
      let(:fixture_name) { 'with label as page heading' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], attributes: { id: fixture_options[:id] }) }

      before do
        fixture_options[:label][:is_page_heading] = fixture_options[:label][:isPageHeading]
        fixture_options[:label].delete(:isPageHeading)
      end

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with optional form-group classes'" do
      let(:fixture_name) { 'with optional form-group classes' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], form_group: fixture_options[:formGroup], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with autocomplete attribute'" do
      let(:fixture_name) { 'with autocomplete attribute' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], attributes: { id: fixture_options[:id], autocomplete: fixture_options[:autocomplete] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with spellcheck enabled'" do
      let(:fixture_name) { 'with spellcheck enabled' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], attributes: { id: fixture_options[:id], spellcheck: fixture_options[:spellcheck] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with spellcheck disabled'" do
      let(:fixture_name) { 'with spellcheck disabled' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], attributes: { id: fixture_options[:id], spellcheck: fixture_options[:spellcheck] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], attributes: { id: fixture_options[:id] }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with describedBy'" do
      let(:fixture_name) { 'with describedBy' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint and described by'" do
      let(:fixture_name) { 'with hint and described by' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message and described by'" do
      let(:fixture_name) { 'with error message and described by' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint and error message'" do
      let(:fixture_name) { 'with hint and error message' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint, error message and described by'" do
      let(:fixture_name) { 'with hint, error message and described by' }
      let(:result) { govuk_textarea(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result.to_one_line).to eq_html(fixture_html)
      end
    end
  end
end
