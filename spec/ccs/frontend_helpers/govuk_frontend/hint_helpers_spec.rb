# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/hint'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Hint, type: :helper do
  include described_class

  let(:hint_element) { Capybara::Node::Simple.new(result).find('div.govuk-hint') }

  describe '.govuk_hint' do
    let(:result) { govuk_hint(hint_text, **options) }
    let(:hint_text) { 'You have to hold it down for 10 seconds' }
    let(:options) { {} }

    let(:default_html) { '<div class="govuk-hint">You have to hold it down for 10 seconds</div>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML' do
        expect(hint_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_hint(hint_text) }

      it 'correctly formats the HTML' do
        expect(hint_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a block' do
      let(:result) do
        govuk_hint(**options) do
          tag.p('Turn off the traction control')
        end
      end

      it 'renders the hint text with the block' do
        expect(hint_element.to_html).to eq('
          <div class="govuk-hint">
            <p>
              Turn off the traction control
            </p>
          </div>
        '.to_one_line)
      end

      context 'and there is text too' do
        let(:result) do
          govuk_hint(hint_text, **options) do
            tag.p('Turn off the traction control')
          end
        end

        it 'renders only the text and not the block' do
          expect(hint_element.to_html).to eq(default_html)
        end
      end
    end
  end
end
