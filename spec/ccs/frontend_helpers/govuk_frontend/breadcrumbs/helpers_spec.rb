# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/breadcrumbs'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Breadcrumbs, '#helpers', type: :helper do
  include described_class

  describe '.govuk_breadcrumbs' do
    let(:result) { govuk_breadcrumbs(items, **options) }

    let(:items) do
      [
        { text: 'Menu', href: '/menu' },
        { text: 'Map', href: '/menu/map' },
        { text: 'Swordmarch' }
      ]
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <nav class="govuk-breadcrumbs" aria-label="Breadcrumb">
          <ol class="govuk-breadcrumbs__list">
            <li class="govuk-breadcrumbs__list-item">
              <a class="govuk-breadcrumbs__link" href="/menu">
                Menu
              </a>
            </li>
            <li class="govuk-breadcrumbs__list-item">
              <a class="govuk-breadcrumbs__link" href="/menu/map">
                Map
              </a>
            </li>
            <li class="govuk-breadcrumbs__list-item" aria-current="page">
              Swordmarch
            </li>
          </ol>
        </nav>
      '.to_one_line
    end

    let(:breadcrumbs_element) { Capybara::Node::Simple.new(result).find('nav.govuk-breadcrumbs') }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the text and content' do
        expect(breadcrumbs_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_breadcrumbs(items) }

      it 'correctly formats the HTML with the text and content' do
        expect(breadcrumbs_element.to_html).to eq(default_html)
      end
    end
  end
end
