# frozen_string_literal: true

require 'ccs/components/govuk/details'

RSpec.describe CCS::Components::GovUK::Details do
  include_context 'and I have a view context'

  let(:details_element) { Capybara::Node::Simple.new(result).find('details.govuk-details') }

  describe '.render' do
    let(:govuk_details) { described_class.new(summary_text: summary_text, context: view_context, **options) }
    let(:result) do
      govuk_details.render do
        summary_details
      end
    end

    let(:summary_text) { 'Ouroboros' }
    let(:summary_details) do
      tag.ul(class: 'govuk-list') do
        %w[Noah Mio Eunie Taion Lanz Senna].each do |ouroboros|
          concat(tag.li(ouroboros))
        end
      end
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <details class="govuk-details" data-module="govuk-details">
          <summary class="govuk-details__summary">
            <span class="govuk-details__summary-text">
              Ouroboros
            </span>
          </summary>
          <div class="govuk-details__text">
            <ul class="govuk-list">
              <li>Noah</li>
              <li>Mio</li>
              <li>Eunie</li>
              <li>Taion</li>
              <li>Lanz</li>
              <li>Senna</li>
            </ul>
          </div>
        </details>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary text and content' do
        expect(details_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_details) { described_class.new(summary_text: summary_text, context: view_context) }

      it 'correctly formats the HTML with the summary text and content' do
        expect(details_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-details' } } }

      it 'has the id' do
        expect(details_element[:id]).to eq('ouroboros-details')
      end
    end

    context 'when the open attribute is passed' do
      let(:options) { { attributes: { open: 'open' } } }

      it 'has the open attribute' do
        expect(details_element[:open]).to eq('open')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(details_element[:class]).to eq('govuk-details my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(details_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
