# frozen_string_literal: true

require 'ccs/components/govuk/label'

RSpec.describe CCS::Components::GovUK::Label do
  include_context 'and I have a view context'

  let(:full_label_element) { Capybara::Node::Simple.new(result) }
  let(:label_element) { full_label_element.find('label.govuk-label') }

  describe '.render' do
    let(:result) { govuk_label.render }

    let(:attribute) { 'ouroboros' }
    let(:label_text) { 'Select your favourite character' }
    let(:options) { {} }

    let(:label_text_block) do
      capture do
        concat(tag.span('DO NOT:', class: 'govuk-visually-hidden'))
        concat('Select your favourite character')
      end
    end

    context 'and there is no form' do
      let(:govuk_label) { described_class.new(attribute: attribute, text: label_text, context: view_context, **options) }

      let(:default_html) { '<label class="govuk-label" for="ouroboros">Select your favourite character</label>' }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the label_text text' do
          expect(label_element.to_html).to eq(default_html)
        end
      end

      context 'when no options are sent' do
        let(:govuk_label) { described_class.new(attribute: attribute, text: label_text, context: view_context) }

        it 'correctly formats the HTML with the label_text text' do
          expect(label_element.to_html).to eq(default_html)
        end
      end

      context 'when a block is passed into the method' do
        let(:govuk_label) { described_class.new(attribute: attribute, context: view_context, **options) }
        let(:result) do
          govuk_label.render do
            label_text_block
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
          govuk_label.render do
            label_text_block
          end
        end

        it 'correctly formats the HTML with the label text' do
          expect(label_element.to_html).to eq(default_html)
        end
      end

      context 'when it is a page heading' do
        let(:options) { { is_page_heading: true } }

        it 'wraps the label in a h1' do
          expect(full_label_element).to have_css('h1.govuk-label-wrapper > label.govuk-label')
        end
      end

      context 'when additional classes are passed' do
        let(:options) { { classes: 'my-custom-class' } }

        it 'has the custom class' do
          expect(label_element[:class]).to eq('govuk-label my-custom-class')
        end
      end

      context 'when additional attributes are passed' do
        let(:options) { { attributes: { data: { test: 'hello there' }, for: 'eunie' } } }

        it 'has the additional attributes' do
          expect(label_element[:'data-test']).to eq('hello there')
          expect(label_element[:for]).to eq('eunie')
        end
      end
    end

    context 'and there is a form' do
      include_context 'and I have a form'

      let(:govuk_label) { described_class.new(attribute: attribute, text: label_text, form: form, context: view_context, **options) }

      let(:default_html) { '<label class="govuk-label" for="test_model_ouroboros">Select your favourite character</label>' }

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the label_text text' do
          expect(label_element.to_html).to eq(default_html)
        end
      end

      context 'when no options are sent' do
        let(:govuk_label) { described_class.new(attribute: attribute, text: label_text, form: form, context: view_context) }

        it 'correctly formats the HTML with the label_text text' do
          expect(label_element.to_html).to eq(default_html)
        end
      end

      context 'when a block is passed into the method' do
        let(:govuk_label) { described_class.new(attribute: attribute, form: form, context: view_context, **options) }
        let(:result) do
          govuk_label.render do
            label_text_block
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
          govuk_label.render do
            label_text_block
          end
        end

        it 'correctly formats the HTML with the label text' do
          expect(label_element.to_html).to eq(default_html)
        end
      end

      context 'when it is a page heading' do
        let(:options) { { is_page_heading: true } }

        it 'wraps the label in a h1' do
          expect(full_label_element).to have_css('h1.govuk-label-wrapper > label.govuk-label')
        end
      end

      context 'when additional classes are passed' do
        let(:options) { { classes: 'my-custom-class' } }

        it 'has the custom class' do
          expect(label_element[:class]).to eq('govuk-label my-custom-class')
        end
      end

      context 'when additional attributes are passed' do
        let(:options) { { attributes: { data: { test: 'hello there' }, for: 'eunie' } } }

        it 'has the additional attributes' do
          expect(label_element[:'data-test']).to eq('hello there')
          expect(label_element[:for]).to eq('eunie')
        end
      end
    end
  end
end
