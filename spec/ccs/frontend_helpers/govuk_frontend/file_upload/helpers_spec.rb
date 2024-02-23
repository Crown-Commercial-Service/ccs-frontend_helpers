# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/file_upload'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::FileUpload, '#helpers', type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: {},
      label: {
        text: 'Upload your favourite artwork'
      }
    }
  end
  let(:minimum_options) do
    {
      label: {
        text: 'Upload your favourite artwork',
      }
    }
  end
  let(:options_with_hint) do
    {
      form_group: {},
      label: {
        text: 'Upload your favourite artwork'
      },
      hint: {
        text: 'This should be of your favourite character'
      }
    }
  end
  let(:test_model) { TestModel.new }

  describe '.govuk_file_upload' do
    let(:result) { govuk_file_upload(attribute, error_message: error_message, **options) }
    let(:error_message) { nil }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Upload your favourite artwork
          </label>
          <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="ouroboros">
                Upload your favourite artwork
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                This should be of your favourite character
              </div>
              <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload" aria-describedby="ouroboros-hint">
            </div>
          '.to_one_line)
        end
      end
    end

    context 'when there is an error message' do
      let(:error_message) { 'You must upload a file' }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Upload your favourite artwork
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must upload a file
            </p>
            <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-error">
          </div>
        '.to_one_line)
      end
    end

    context 'when there is a hint and an error message' do
      let(:error_message) { 'You must upload a file' }
      let(:options) { options_with_hint }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Upload your favourite artwork
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              This should be of your favourite character
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error:</span> You must upload a file
            </p>
            <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-hint ouroboros-error">
          </div>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_file_upload with model' do
    let(:result) { govuk_file_upload(attribute, model: test_model, **options) }

    let(:default_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="ouroboros">
            Upload your favourite artwork
          </label>
          <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_file_upload(attribute, model: test_model, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_file_upload with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form from a model'

    let(:result) { govuk_file_upload(attribute, form: form, **options) }

    let(:defeat_html) do
      '
        <div class="govuk-form-group" id="ouroboros-form-group">
          <label class="govuk-label" for="test_model_ouroboros">
            Upload your favourite artwork
          </label>
          <input class="govuk-file-upload" type="file" name="test_model[ouroboros]" id="test_model_ouroboros">
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end

    context 'when some options are not passed' do
      let(:result) { govuk_file_upload(attribute, form: form, **options) }
      let(:options) { minimum_options }

      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end
  end
end
