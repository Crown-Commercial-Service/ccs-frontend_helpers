# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/form_group'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::FormGroup, type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }

  let(:attribute) { 'ouroboros' }
  let(:options) { {} }

  let(:default_html) do
    '
      <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
        <label for="ouroboros">Ouroboros</label>
        <p class="govuk-error-message" id="ouroboros-error">
          <span class="govuk-visually-hidden">Error: </span>
          There is an enemy in our path
        </p>
        <input id="ouroboros">
      </div>
    '.to_one_line
  end
  let(:no_error_html) do
    '
      <div class="govuk-form-group" id="ouroboros-form-group">
        <label for="ouroboros">Ouroboros</label>
        <input id="ouroboros">
      </div>
    '.to_one_line
  end

  describe '.govuk_form_group' do
    let(:result) do
      govuk_form_group(attribute, error_message: error_message, **options) do |displayed_error_message|
        concat(tag.label('Ouroboros', for: 'ouroboros'))
        concat(displayed_error_message)
        concat(tag.input(id: 'ouroboros'))
      end
    end

    let(:error_message) { 'There is an enemy in our path' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the ID derived from the attribute and content' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) do
        govuk_form_group(attribute, error_message: error_message) do |displayed_error_message|
          concat(tag.label('Ouroboros', for: 'ouroboros'))
          concat(displayed_error_message)
          concat(tag.input(id: 'ouroboros'))
        end
      end

      it 'correctly formats the HTML with the ID derived from the attribute and content' do
        expect(form_group_element.to_html).to eq(default_html)
      end
    end

    context 'when no error message is sent' do
      let(:result) do
        govuk_form_group(attribute, **options) do |displayed_error_message|
          concat(tag.label('Ouroboros', for: 'ouroboros'))
          concat(displayed_error_message)
          concat(tag.input(id: 'ouroboros'))
        end
      end

      it 'correctly formats the HTML without the error message' do
        expect(form_group_element.to_html).to eq(no_error_html)
      end

      context 'and no options are sent' do
        let(:result) do
          govuk_form_group(attribute) do |displayed_error_message|
            concat(tag.label('Ouroboros', for: 'ouroboros'))
            concat(displayed_error_message)
            concat(tag.input(id: 'ouroboros'))
          end
        end

        it 'correctly formats the HTML without the error message' do
          expect(form_group_element.to_html).to eq(no_error_html)
        end
      end
    end

    context 'when a custom ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(form_group_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(form_group_element[:class]).to eq('govuk-form-group govuk-form-group--error my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(form_group_element[:'data-test']).to eq('hello there')
      end
    end
  end

  describe '.govuk_form_group with model' do
    let(:result) do
      govuk_form_group(attribute, model: model, **options) do |displayed_error_message|
        concat(tag.label('Ouroboros', for: 'ouroboros'))
        concat(displayed_error_message)
        concat(tag.input(id: 'ouroboros'))
      end
    end

    let(:model) { TestModel.new }

    context 'and there is an error' do
      before { model.errors.add(:ouroboros, message: 'There is an enemy in our path') }

      it 'correctly formats the HTML with the error message derived from the model and ID derived from the attribute' do
        expect(form_group_element.to_html).to eq(default_html)
      end

      context 'when no options are sent' do
        let(:result) do
          govuk_form_group(attribute, model: model) do |displayed_error_message|
            concat(tag.label('Ouroboros', for: 'ouroboros'))
            concat(displayed_error_message)
            concat(tag.input(id: 'ouroboros'))
          end
        end

        it 'correctly formats the HTML with the ID derived from the attribute and content' do
          expect(form_group_element.to_html).to eq(default_html)
        end
      end
    end

    context 'and there is no error' do
      it 'correctly formats the HTML without the error message' do
        expect(form_group_element.to_html).to eq(no_error_html)
      end

      context 'and no options are sent' do
        let(:result) do
          govuk_form_group(attribute, model: model) do |displayed_error_message|
            concat(tag.label('Ouroboros', for: 'ouroboros'))
            concat(displayed_error_message)
            concat(tag.input(id: 'ouroboros'))
          end
        end

        it 'correctly formats the HTML without the error message' do
          expect(form_group_element.to_html).to eq(no_error_html)
        end
      end
    end

    context 'when a custom ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(form_group_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(form_group_element[:class]).to eq('govuk-form-group my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(form_group_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
