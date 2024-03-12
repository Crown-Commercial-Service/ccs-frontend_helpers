# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/exit_this_page'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ExitThisPage, '#helpers', type: :helper do
  include described_class

  let(:exit_this_page_element) { Capybara::Node::Simple.new(result).find('div.govuk-exit-this-page') }

  describe '.govuk_exit_this_page' do
    let(:result) { govuk_exit_this_page(**options) }

    let(:options) { {} }

    let(:default_html) do
      '
      <div class="govuk-exit-this-page" data-module="govuk-exit-this-page">
        <a rel="nofollow noreferrer" class="govuk-button govuk-button--warning govuk-exit-this-page__button govuk-js-exit-this-page-button" data-module="govuk-button" role="button" draggable="false" href="https://www.bbc.co.uk/weather">
          <span class="govuk-visually-hidden">Emergency</span> Exit this page
        </a>
      </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the button' do
        expect(exit_this_page_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_exit_this_page }

      it 'correctly formats the HTML with the button' do
        expect(exit_this_page_element.to_html).to eq(default_html)
      end
    end
  end
end
