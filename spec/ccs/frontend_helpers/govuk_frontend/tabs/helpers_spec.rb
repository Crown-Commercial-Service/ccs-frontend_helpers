# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/tabs'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tabs, '#helpers', type: :helper do
  include described_class

  let(:tabs_element) { Capybara::Node::Simple.new(result).find('div.govuk-tabs') }

  describe '.govuk_tabs' do
    let(:result) { govuk_tabs(tabs, title, **options) }

    let(:tabs) do
      [
        {
          label: 'Eunie',
          panel: {
            content: tag.div('Eunie is apparently, and this her words not mine, "the boss"', class: 'my-random-content'),
            attributes: {
              id: 'eunie'
            }
          }
        },
        {
          label: 'Mio',
          panel: {
            text: 'A delicate yet strong individual with a strong sense for justice',
            attributes: {
              id: 'mio'
            }
          }
        },
        {
          label: 'Noah',
          panel: {
            text: 'Keves\' finest fighter but looking for peace',
            attributes: {
              id: 'noah'
            }
          }
        },
      ]
    end
    let(:title) { 'Ouroboros information' }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-tabs" data-module="govuk-tabs">
          <h2 class="govuk-tabs__title">
            Ouroboros information
          </h2>
          <ul class="govuk-tabs__list">
            <li class="govuk-tabs__list-item govuk-tabs__list-item--selected">
              <a class="govuk-tabs__tab" href="#eunie">
                Eunie
              </a>
            </li>
            <li class="govuk-tabs__list-item">
              <a class="govuk-tabs__tab" href="#mio">
                Mio
              </a>
            </li>
            <li class="govuk-tabs__list-item">
              <a class="govuk-tabs__tab" href="#noah">
                Noah
              </a>
            </li>
          </ul>
          <div id="eunie" class="govuk-tabs__panel">
            <div class="my-random-content">
              Eunie is apparently, and this her words not mine, "the boss"
            </div>
          </div>
          <div id="mio" class="govuk-tabs__panel govuk-tabs__panel--hidden">
            <p class="govuk-body">
              A delicate yet strong individual with a strong sense for justice
            </p>
          </div>
          <div id="noah" class="govuk-tabs__panel govuk-tabs__panel--hidden">
            <p class="govuk-body">
              Keves\' finest fighter but looking for peace
            </p>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the tabs' do
        expect(tabs_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_tabs(tabs, title) }

      it 'correctly formats the HTML with the tabs' do
        expect(tabs_element.to_html).to eq(default_html)
      end
    end

    context 'when the title is not passed' do
      let(:result) { govuk_tabs(tabs, **options) }

      it 'defaults to Contents' do
        expect(tabs_element).to have_css('h2.govuk-tabs__title', text: 'Contents')
      end
    end
  end
end
