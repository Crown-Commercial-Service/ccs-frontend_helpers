# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/form_group'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::FormGroup, '#helpers', type: :helper do
  include described_class

  let(:form_group_element) { Capybara::Node::Simple.new(result).find('div.govuk-form-group') }

  let(:attribute) { 'ouroboros' }
  let(:options) { {} }

  let(:default_html) do
    '
      <div class="govuk-form-group govuk-form-group--error" id="ouroboros-form-group">
        <label for="ouroboros">Ouroboros</label>
        <p class="govuk-error-message" id="ouroboros-error">
          <span class="govuk-visually-hidden">Error:</span> There is an enemy in our path
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

    context 'when there is a model' do
      let(:test_model) { TestModel.new }

      let(:result) do
        govuk_form_group(attribute, model: test_model, **options) do |displayed_error_message|
          concat(tag.label('Ouroboros', for: 'ouroboros'))
          concat(displayed_error_message)
          concat(tag.input(id: 'ouroboros'))
        end
      end

      context 'and there is no error' do
        it 'correctly formats the HTML without the error message' do
          expect(form_group_element.to_html).to eq(no_error_html)
        end
      end

      context 'and there is an error' do
        before { test_model.errors.add(attribute, error_message) }

        it 'correctly formats the HTML with the error message' do
          expect(form_group_element.to_html).to eq(default_html)
        end
      end
    end
  end
end
