# frozen_string_literal: true

require 'ccs/components/govuk/hint'

RSpec.describe CCS::Components::GovUK::Hint do
  include_context 'and I have a view context'

  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }

  describe '.render' do
    let(:govuk_hint) { described_class.new(text: hint_text, context: view_context, **options) }
    let(:result) { govuk_hint.render }

    let(:hint_text) { 'You have to hold it down for 10 seconds' }
    let(:options) { {} }

    let(:default_html) { '<div class="govuk-hint">You have to hold it down for 10 seconds</div>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the hint text' do
        expect(hint_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_hint) { described_class.new(text: hint_text, context: view_context) }

      it 'correctly formats the HTML with the hint text' do
        expect(hint_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(hint_element[:class]).to eq('govuk-hint my-custom-class')
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'turn-on-traction-control-hint' } } }

      it 'has the id' do
        expect(hint_element[:id]).to eq('turn-on-traction-control-hint')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(hint_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when there is a block' do
      let(:govuk_hint) { described_class.new(context: view_context, **options) }
      let(:result) do
        govuk_hint.render do
          tag.p('Come on, who else?')
        end
      end

      it 'renders the hint with the block' do
        expect(hint_element.to_html).to eq('
          <div class="govuk-hint">
            <p>
              Come on, who else?
            </p>
          </div>
        '.to_one_line)
      end

      context 'and there is text too' do
        let(:govuk_hint) { described_class.new(text: hint_text, context: view_context, **options) }

        it 'renders only the text and not the block' do
          expect(hint_element.to_html).to eq(default_html)
        end
      end
    end
  end
end
