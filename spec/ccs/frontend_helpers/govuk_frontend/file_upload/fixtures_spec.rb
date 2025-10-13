# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/file_upload'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::FileUpload, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_file_upload from fixtures' do
    include_context 'and I have loaded the GOV.UK Frontend fixture'
    include_context 'and I am using a field fixture'

    let(:component_name) { 'file-upload' }

    before do
      fixture_options[:name] ||= fixture_options[:id]

      %i[id disabled multiple].each do |attribute|
        next if fixture_options[attribute].nil?

        fixture_options[:attributes] ||= {}
        fixture_options[:attributes][attribute] = fixture_options[attribute]
        fixture_options.delete(attribute)
      end

      fixture_html.gsub!('divclass=', 'div class=')
    end

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'allows multiple files'" do
      let(:fixture_name) { 'allows multiple files' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'disabled'" do
      let(:fixture_name) { 'disabled' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint text'" do
      let(:fixture_name) { 'with hint text' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error message and hint'" do
      let(:fixture_name) { 'with error message and hint' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with label as page heading'" do
      let(:fixture_name) { 'with label as page heading' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label]) }

      before { fixture_options[:label][:is_page_heading] = fixture_options[:label][:isPageHeading] }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with optional form-group classes'" do
      let(:fixture_name) { 'with optional form-group classes' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], form_group: fixture_options[:formGroup]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'enhanced'" do
      let(:fixture_name) { 'enhanced' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], javascript: fixture_options[:javascript]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'enhanced, with error message and hint'" do
      let(:fixture_name) { 'enhanced, with error message and hint' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], javascript: fixture_options[:javascript], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'enhanced, multiple files'" do
      let(:fixture_name) { 'enhanced, multiple files' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], javascript: fixture_options[:javascript], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'translated'" do
      let(:fixture_name) { 'translated' }
      let(:result) do
        govuk_file_upload(
          fixture_options[:name],
          label: fixture_options[:label],
          javascript: fixture_options[:javascript],
          choose_files_button_text: fixture_options[:chooseFilesButtonText],
          no_file_chosen_text: fixture_options[:noFileChosenText],
          multiple_files_chosen_text: fixture_options[:multipleFilesChosenText],
          drop_instruction_text: fixture_options[:dropInstructionText],
          entered_drop_zone_text: fixture_options[:enteredDropZoneText],
          left_drop_zone_text: fixture_options[:leftDropZoneText],
          attributes: fixture_options[:attributes]
        )
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'attributes'" do
      let(:fixture_name) { 'attributes' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'classes'" do
      let(:fixture_name) { 'classes' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], classes: fixture_options[:classes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'id'" do
      let(:fixture_name) { 'id' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], attributes: fixture_options[:attributes]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with describedBy'" do
      let(:fixture_name) { 'with describedBy' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with hint and describedBy'" do
      let(:fixture_name) { 'with hint and describedBy' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'error'" do
      let(:fixture_name) { 'error' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error and describedBy'" do
      let(:fixture_name) { 'with error and describedBy' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], error_message: fixture_options[:errorMessage][:text], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'with error, describedBy and hint'" do
      let(:fixture_name) { 'with error, describedBy and hint' }
      let(:result) { govuk_file_upload(fixture_options[:name], label: fixture_options[:label], hint: fixture_options[:hint], error_message: fixture_options[:errorMessage][:text], attributes: { aria: { describedby: fixture_options[:describedBy] } }) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'translated, no javascript enhancement'" do
      let(:fixture_name) { 'translated, no javascript enhancement' }
      let(:result) do
        govuk_file_upload(
          fixture_options[:name],
          label: fixture_options[:label],
          choose_files_button_text: fixture_options[:chooseFilesButtonText],
          no_file_chosen_text: fixture_options[:noFileChosenText],
          multiple_files_chosen_text: fixture_options[:multipleFilesChosenText],
          drop_instruction_text: fixture_options[:dropInstructionText],
          entered_drop_zone_text: fixture_options[:enteredDropZoneText],
          left_drop_zone_text: fixture_options[:leftDropZoneText],
          attributes: fixture_options[:attributes]
        )
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
