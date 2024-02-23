# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/inset_text'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::InsetText, '#helpers', type: :helper do
  include described_class

  let(:inset_text_element) { Capybara::Node::Simple.new(result).find('div.govuk-inset-text') }

  describe '.govuk_inset_text' do
    let(:result) { govuk_inset_text(text, **options) }

    let(:text) { "Eunie's the boss" }
    let(:options) { {} }

    let(:default_html) { '<div class="govuk-inset-text">Eunie\'s the boss</div>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the link' do
        expect(inset_text_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_inset_text(text) }

      it 'correctly formats the HTML with the link' do
        expect(inset_text_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a block' do
      let(:result) do
        govuk_inset_text(**options) do
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
        let(:result) do
          govuk_inset_text(text, **options) do
            tag.p('Come on, who else?')
          end
        end

        it 'renders only the text and not the block' do
          expect(inset_text_element.to_html).to eq(default_html)
        end
      end
    end
  end
end
