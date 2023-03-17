# frozen_string_literal: true

require 'ccs/components/govuk/back_link'

RSpec.describe CCS::Components::GovUK::BackLink do
  include_context 'and I have a view context'

  let(:back_link_element) { Capybara::Node::Simple.new(result).find('a.govuk-back-link') }

  describe '.render' do
    let(:govuk_back_link) { described_class.new(text: text, href: href, context: view_context, **options) }
    let(:result) { govuk_back_link.render }

    let(:text) { 'Back' }
    let(:href) { '/back' }
    let(:options) { {} }

    let(:default_html) { '<a class="govuk-back-link" href="/back">Back</a>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the link' do
        expect(back_link_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_back_link) { described_class.new(text: text, href: href, context: view_context) }

      it 'correctly formats the HTML with the link' do
        expect(back_link_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-back-link' } } }

      it 'has the id' do
        expect(back_link_element[:id]).to eq('ouroboros-back-link')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(back_link_element[:class]).to eq('govuk-back-link my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(back_link_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
