# frozen_string_literal: true

require 'ccs/components/govuk/field/input/file_upload'

RSpec.describe CCS::Components::GovUK::Field::Input::FileUpload do
  include_context 'and I have a view context'

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }
  let(:label_element) { Capybara::Node::Simple.new(result).find('label.govuk-label') }
  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }
  let(:error_message_element) { Capybara::Node::Simple.new(result).find('p.govuk-error-message') }
  let(:file_upload_element) { Capybara::Node::Simple.new(result).find('input.govuk-file-upload') }

  let(:result) { govuk_file_upload.render }

  let(:attribute) { 'ouroboros' }
  let(:options) do
    {
      form_group: form_group_options,
      label: {
        text: 'Upload your favourite artwork'
      }.merge(label_options)
    }.merge(file_upload_options)
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
      form_group: form_group_options,
      label: {
        text: 'Upload your favourite artwork'
      }.merge(label_options),
      hint: {
        text: 'This should be of your favourite character'
      }.merge(hint_options)
    }.merge(file_upload_options)
  end
  let(:form_group_options) { {} }
  let(:label_options) { {} }
  let(:hint_options) { {} }
  let(:file_upload_options) { {} }
  let(:model) { TestModel.new }

  describe '.render' do
    let(:govuk_file_upload) { described_class.new(attribute: attribute, error_message: error_message, context: view_context, **options) }
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

    context 'when some options are not passed' do
      let(:govuk_file_upload) { described_class.new(attribute: attribute, context: view_context, **options) }

      let(:options) { minimum_options }

      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:file_upload_options) { { classes: 'my-custom-file-upload-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(file_upload_element[:class]).to eq('govuk-file-upload my-custom-file-upload-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:file_upload_options) { { attributes: { id: 'my-custom-file-upload-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(file_upload_element[:id]).to eq('my-custom-file-upload-id')
      end
    end

    context 'when a custom name is passed' do
      let(:file_upload_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the file upload' do
        expect(file_upload_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom type is passed' do
      let(:file_upload_options) { { attributes: { type: 'number' } } }

      it 'has the file type' do
        expect(file_upload_element[:type]).to eq('file')
      end
    end

    context 'when custom attributes are passed' do
      let(:file_upload_options) { { attributes: { pattern: '[0-9]*', value: '/path/to/eunie/artwork', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the additional attributes for the file upload' do
        expect(file_upload_element[:value]).to eq('/path/to/eunie/artwork')
        expect(file_upload_element[:pattern]).to eq('[0-9]*')
        expect(file_upload_element[:'aria-describedby']).to eq('some-id')
        expect(file_upload_element[:'data-test']).to eq('my data value')
      end
      # rubocop:enable RSpec/MultipleExpectations
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

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the file upload has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(file_upload_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom and hint id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
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
              <span class="govuk-visually-hidden">Error: </span>
              You must upload a file
            </p>
            <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom and error id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
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
              <span class="govuk-visually-hidden">Error: </span>
              You must upload a file
            </p>
            <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-hint ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom, hint and error id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end
  end

  describe '.render with model' do
    let(:govuk_file_upload) { described_class.new(attribute: attribute, model: model, context: view_context, **options) }

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
      let(:options) { minimum_options }

      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:file_upload_options) { { classes: 'my-custom-file-upload-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(file_upload_element[:class]).to eq('govuk-file-upload my-custom-file-upload-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:file_upload_options) { { attributes: { id: 'my-custom-file-upload-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(file_upload_element[:id]).to eq('my-custom-file-upload-id')
      end
    end

    context 'when a custom name is passed' do
      let(:file_upload_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the file upload' do
        expect(file_upload_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom type is passed' do
      let(:file_upload_options) { { attributes: { type: 'number' } } }

      it 'has the file type' do
        expect(file_upload_element[:type]).to eq('file')
      end
    end

    context 'when custom attributes are passed' do
      let(:file_upload_options) { { attributes: { pattern: '[0-9]*', value: '/path/to/eunie/artwork', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the additional attributes for the file upload' do
        expect(file_upload_element[:value]).to eq('/path/to/eunie/artwork')
        expect(file_upload_element[:pattern]).to eq('[0-9]*')
        expect(file_upload_element[:'aria-describedby']).to eq('some-id')
        expect(file_upload_element[:'data-test']).to eq('my data value')
      end
      # rubocop:enable RSpec/MultipleExpectations
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

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the file upload has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(file_upload_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom and hint id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { model.errors.add(:ouroboros, message: 'You must upload a file') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="ouroboros">
              Upload your favourite artwork
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error: </span>
              You must upload a file
            </p>
            <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom and error id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }

      before { model.errors.add(:ouroboros, message: 'You must upload a file') }

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
              <span class="govuk-visually-hidden">Error: </span>
              You must upload a file
            </p>
            <input type="file" name="ouroboros" id="ouroboros" class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-hint ouroboros-error">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom, hint and error id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form from a model'

    let(:govuk_file_upload) { described_class.new(attribute: attribute, form: form, context: view_context, **options) }

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
      let(:options) { minimum_options }

      it 'correctly formats the HTML with file upload input in the form' do
        expect(form_group_element.to_html).to eq(defeat_html)
      end
    end

    context 'when additional classes are passed' do
      let(:form_group_options) { { classes: 'my-custom-form-group-class' } }
      let(:label_options) { { classes: 'my-custom-label-class' } }
      let(:file_upload_options) { { classes: 'my-custom-file-upload-class' } }

      it 'has the custom classes' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-form-group-class')
        expect(label_element[:class]).to eq('govuk-label my-custom-label-class')
        expect(file_upload_element[:class]).to eq('govuk-file-upload my-custom-file-upload-class')
      end
    end

    context 'when additional ids are passed' do
      let(:form_group_options) { { attributes: { id: 'my-custom-form-group-id' } } }
      let(:label_options) { { attributes: { id: 'my-custom-label-id' } } }
      let(:file_upload_options) { { attributes: { id: 'my-custom-file-upload-id' } } }

      it 'has the custom ids' do
        expect(form_group_element[:id]).to eq('my-custom-form-group-id')
        expect(label_element[:id]).to eq('my-custom-label-id')
        expect(file_upload_element[:id]).to eq('my-custom-file-upload-id')
      end
    end

    context 'when a custom name is passed' do
      let(:file_upload_options) { { attributes: { name: 'my-custom-name' } } }

      it 'has the custom name in the file upload' do
        expect(file_upload_element[:name]).to eq('my-custom-name')
      end
    end

    context 'when a custom type is passed' do
      let(:file_upload_options) { { attributes: { type: 'number' } } }

      it 'has the custom type in the file upload' do
        expect(file_upload_element[:type]).to eq('number')
      end
    end

    context 'when custom attributes are passed' do
      let(:file_upload_options) { { attributes: { pattern: '[0-9]*', value: '/path/to/eunie/artwork', aria: { describedby: 'some-id' }, data: { test: 'my data value' } } } }

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the additional attributes for the file upload' do
        expect(file_upload_element[:value]).to eq('/path/to/eunie/artwork')
        expect(file_upload_element[:pattern]).to eq('[0-9]*')
        expect(file_upload_element[:'aria-describedby']).to eq('some-id')
        expect(file_upload_element[:'data-test']).to eq('my data value')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end

    context 'when there is a hint' do
      let(:options) { options_with_hint }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the hint' do
          expect(form_group_element.to_html).to eq('
            <div class="govuk-form-group" id="ouroboros-form-group">
              <label class="govuk-label" for="test_model_ouroboros">
                Upload your favourite artwork
              </label>
              <div id="ouroboros-hint" class="govuk-hint">
                This should be of your favourite character
              </div>
              <input class="govuk-file-upload" aria-describedby="ouroboros-hint" type="file" name="test_model[ouroboros]" id="test_model_ouroboros">
            </div>
          '.to_one_line)
        end
      end

      context 'when additional classes are passed' do
        let(:hint_options) { { classes: 'my-custom-hint-class' } }

        it 'has the custom classes for the hint' do
          expect(hint_element[:class]).to eq('govuk-hint my-custom-hint-class')
        end
      end

      context 'when additional ids are passed' do
        let(:hint_options) { { attributes: { id: 'my-custom-hint-id' } } }

        it 'has the custom id for the hint and the file upload has it in its area describedby' do
          expect(hint_element[:id]).to eq('my-custom-hint-id')
          expect(file_upload_element[:'aria-describedby']).to eq('my-custom-hint-id')
        end
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom and hint id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-hint')
        end
      end
    end

    context 'when there is an error message' do
      before { model.errors.add(:ouroboros, message: 'You must upload a file') }

      it 'correctly formats the HTML with error message and classes' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Upload your favourite artwork
            </label>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error: </span>
              You must upload a file
            </p>
            <input class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-error" type="file" name="test_model[ouroboros]" id="test_model_ouroboros">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom and error id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-error')
        end
      end
    end

    context 'when there is a hint and an error message' do
      let(:options) { options_with_hint }

      before { model.errors.add(:ouroboros, message: 'You must upload a file') }

      it 'correctly formats the HTML with error message and the hint with the aria-describedby from the hint then error message' do
        expect(form_group_element.to_html).to eq('
          <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
            <label class="govuk-label" for="test_model_ouroboros">
              Upload your favourite artwork
            </label>
            <div id="ouroboros-hint" class="govuk-hint">
              This should be of your favourite character
            </div>
            <p class="govuk-error-message" id="ouroboros-error">
              <span class="govuk-visually-hidden">Error: </span>
              You must upload a file
            </p>
            <input class="govuk-file-upload govuk-file-upload--error" aria-describedby="ouroboros-hint ouroboros-error" type="file" name="test_model[ouroboros]" id="test_model_ouroboros">
          </div>
        '.to_one_line)
      end

      context 'when aria-describedby attribute for the file upload is passed' do
        let(:file_upload_options) { { attributes: { aria: { describedby: 'some-id' } } } }

        it 'has the file upload aria described by as the custom, hint and error id' do
          expect(file_upload_element[:'aria-describedby']).to eq('some-id ouroboros-hint ouroboros-error')
        end
      end
    end
  end
end
