# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/label'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Label, type: :helper do
  include described_class

  let(:full_label_element) { Capybara::Node::Simple.new(result) }
  let(:label_element) { full_label_element.find('label.govuk-label') }

  let(:attribute) { 'ouroboros' }
  let(:label_text) { 'Select your favourite character' }
  let(:options) { {} }

  let(:lable_text_block) do
    capture do
      concat(tag.span('DO NOT:', class: 'govuk-visually-hidden'))
      concat('Select your favourite character')
    end
  end

  describe '.govuk_label' do
    let(:result) { govuk_label(attribute, label_text, **options) }

    let(:default_html) { '<label class="govuk-label" for="ouroboros">Select your favourite character</label>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the label_text text' do
        expect(label_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_label(attribute, label_text) }

      it 'correctly formats the HTML with the label_text text' do
        expect(label_element.to_html).to eq(default_html)
      end
    end

    context 'when a block is passed into the method' do
      let(:result) do
        govuk_label(attribute, **options) do
          lable_text_block
        end
      end

      it 'correctly formats the HTML with the HTML from the block' do
        expect(label_element.to_html).to eq('
          <label class="govuk-label" for="ouroboros">
            <span class="govuk-visually-hidden">
              DO NOT:
            </span>
            Select your favourite character
          </label>
        '.to_one_line)
      end
    end

    context 'when a block is passed into the method with label text' do
      let(:result) do
        govuk_label(attribute, label_text, **options) do
          lable_text_block
        end
      end

      it 'correctly formats the HTML with the label text' do
        expect(label_element.to_html).to eq(default_html)
      end
    end
  end

  describe '.govuk_label with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form'

    let(:result) { govuk_label(attribute, label_text, form: form, **options) }

    let(:default_html) { '<label class="govuk-label" for="test_model_ouroboros">Select your favourite character</label>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the label_text text' do
        expect(label_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_label(attribute, label_text, form: form) }

      it 'correctly formats the HTML with the label_text text' do
        expect(label_element.to_html).to eq(default_html)
      end
    end

    context 'when a block is passed into the method' do
      let(:result) do
        govuk_label(attribute, form: form, **options) do
          lable_text_block
        end
      end

      it 'correctly formats the HTML with the HTML from the block' do
        expect(label_element.to_html).to eq('
          <label class="govuk-label" for="test_model_ouroboros">
            <span class="govuk-visually-hidden">
              DO NOT:
            </span>
            Select your favourite character
          </label>
        '.to_one_line)
      end
    end

    context 'when a block is passed into the method with label text' do
      let(:result) do
        govuk_label(attribute, label_text, form: form, **options) do
          lable_text_block
        end
      end

      it 'correctly formats the HTML with the label text' do
        expect(label_element.to_html).to eq(default_html)
      end
    end
  end
end
