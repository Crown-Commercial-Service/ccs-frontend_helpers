# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/details'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Details, type: :helper do
  include described_class

  let(:details_element) { Capybara::Node::Simple.new(result).find('details.govuk-details') }

  describe '.govuk_details' do
    let(:result) do
      govuk_details(summary_text, **options) do
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
      let(:result) do
        govuk_details(summary_text) do
          summary_details
        end
      end

      it 'correctly formats the HTML with the summary text and content' do
        expect(details_element.to_html).to eq(default_html)
      end
    end
  end
end
