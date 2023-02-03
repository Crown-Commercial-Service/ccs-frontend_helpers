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
      it 'correctly formats the HTML with the hint text' do
        expect(hint_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_hint(hint_text) }

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
  end
end
