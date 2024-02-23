# frozen_string_literal: true

require 'ccs/components/govuk/error_summary/item'

RSpec.describe CCS::Components::GovUK::ErrorSummary::Item do
  include_context 'and I have a view context'

  let(:error_summary_item_element) { Capybara::Node::Simple.new(result).find('li') }

  describe '.render' do
    let(:govuk_error_summary_item) { described_class.new(context: view_context, **item) }
    let(:result) { govuk_error_summary_item.render }

    context 'when the text and link are passed' do
      let(:item) { { text: 'You must select your favourite character', href: '#favourite-character-error' } }

      it 'correctly formats the HTML with the link' do
        expect(error_summary_item_element.to_html).to eq('
          <li>
            <a href="#favourite-character-error">
              You must select your favourite character
            </a>
          </li>
        '.to_one_line)
      end

      context 'when custom attributes are sent' do
        let(:item) { super().merge({ attributes: { id: 'my-error', aria: { describedby: 'my-error' } } }) }

        it 'has the additional attributes on the link' do
          error_summary_item_anchor_element = error_summary_item_element.find('a')

          expect(error_summary_item_anchor_element[:id]).to eq('my-error')
          expect(error_summary_item_anchor_element[:'aria-describedby']).to eq('my-error')
        end
      end
    end

    context 'when only the text is passed' do
      let(:item) { { text: 'You must select your least favourite character' } }

      it 'has the error message in the li without a link' do
        expect(error_summary_item_element).to have_no_css('a', text: 'You must select your least favourite character')
        expect(error_summary_item_element).to have_content('You must select your least favourite character')
      end

      context 'when custom attributes are sent' do
        let(:item) { super().merge({ attributes: { id: 'my-error', aria: { describedby: 'my-error' } } }) }

        it 'does not have the additional attributes' do
          expect(error_summary_item_element[:id]).to be_nil
          expect(error_summary_item_element[:'aria-describedby']).to be_nil
        end
      end
    end
  end
end
