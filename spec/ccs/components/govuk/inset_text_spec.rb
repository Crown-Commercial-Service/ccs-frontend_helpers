# frozen_string_literal: true

require 'ccs/components/govuk/inset_text'

RSpec.describe CCS::Components::GovUK::InsetText do
  include_context 'and I have a view context'

  let(:inset_text_element) { Capybara::Node::Simple.new(result).find('div.govuk-inset-text') }

  describe '.render' do
    let(:govuk_inset_text) { described_class.new(text: text, context: view_context, **options) }
    let(:result) { govuk_inset_text.render }

    let(:text) { "Eunie's the boss" }
    let(:options) { {} }

    let(:default_html) { '<div class="govuk-inset-text">Eunie\'s the boss</div>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the link' do
        expect(inset_text_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_inset_text) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the link' do
        expect(inset_text_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-inset-text' } } }

      it 'has the id' do
        expect(inset_text_element[:id]).to eq('ouroboros-inset-text')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(inset_text_element[:class]).to eq('govuk-inset-text my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(inset_text_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when there is a block' do
      let(:govuk_inset_text) { described_class.new(context: view_context, **options) }
      let(:result) do
        govuk_inset_text.render do
          tag.p('Come on, who else?')
        end
      end

      it 'renders the inset text with the block' do
        expect(inset_text_element.to_html).to eq('
          <div class="govuk-inset-text">
            <p>
              Come on, who else?
            </p>
          </div>
        '.to_one_line)
      end

      context 'and there is text too' do
        let(:govuk_inset_text) { described_class.new(text: text, context: view_context, **options) }

        it 'renders only the text and not the block' do
          expect(inset_text_element.to_html).to eq(default_html)
        end
      end
    end
  end
end
