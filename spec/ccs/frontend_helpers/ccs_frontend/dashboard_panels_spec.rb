# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/dashboard_panels'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::DashboardPanels, type: :helper do
  include described_class

  let(:dashboard_panels_element) { Capybara::Node::Simple.new(result).find('div.ccs-dashboard-panels') }
  let(:dashboard_panels_item_element) { dashboard_panels_element.find('div.ccs-dashboard-panels__item') }

  describe '.ccs_dashboard_panels' do
    let(:result) { ccs_dashboard_panels(panel_items, title_text, **options) }

    let(:panel_items) do
      [
        {
          title: 'Eunie',
          href: '/eunie',
          description: "Eunie's the boss"
        },
        {
          title: 'Noah',
          href: '/noah',
          description: 'Noah is not the boss'
        },
        {
          title: 'Lanz',
          href: '/lanz',
          description: 'Lanz is not the boss'
        }
      ]
    end
    let(:title_text) { 'Ouroboros' }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="ccs-dashboard-panels">
          <div class="govuk-grid-row">
            <div class="govuk-grid-column-full">
              <h2 class="ccs-dashboard-panels__heading govuk-heading-m">
                Ouroboros
              </h2>
              <hr class="ccs-dashboard-panels__heading-section-break govuk-section-break govuk-section-break--visible">
              <div class="ccs-dashboard-panels__container">
                <div class="govuk-grid-row">
                  <div class="ccs-dashboard-panels__item govuk-grid-column-one-third">
                    <a class="ccs-dashboard-panels__item-title" href="/eunie">
                      Eunie
                    </a>
                    <p class="ccs-dashboard-panels__item-description">
                      Eunie\'s the boss
                    </p>
                  </div>
                  <div class="ccs-dashboard-panels__item govuk-grid-column-one-third">
                    <a class="ccs-dashboard-panels__item-title" href="/noah">
                      Noah
                    </a>
                    <p class="ccs-dashboard-panels__item-description">
                      Noah is not the boss
                    </p>
                  </div>
                  <div class="ccs-dashboard-panels__item govuk-grid-column-one-third">
                    <a class="ccs-dashboard-panels__item-title" href="/lanz">
                      Lanz
                    </a>
                    <p class="ccs-dashboard-panels__item-description">
                      Lanz is not the boss
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the dashboard panels' do
        expect(dashboard_panels_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { ccs_dashboard_panels(panel_items, title_text) }

      it 'correctly formats the HTML for the dashboard panels' do
        expect(dashboard_panels_element.to_html).to eq(default_html)
      end
    end

    context 'when there is no title text' do
      let(:result) { ccs_dashboard_panels(panel_items, **options) }

      it 'correctly formats the HTML for the dashboard panels without the title text' do
        expect(dashboard_panels_element.to_html).to eq('
          <div class="ccs-dashboard-panels">
            <div class="govuk-grid-row">
              <div class="govuk-grid-column-full">
                <div class="ccs-dashboard-panels__container">
                  <div class="govuk-grid-row">
                    <div class="ccs-dashboard-panels__item govuk-grid-column-one-third">
                      <a class="ccs-dashboard-panels__item-title" href="/eunie">
                        Eunie
                      </a>
                      <p class="ccs-dashboard-panels__item-description">
                        Eunie\'s the boss
                      </p>
                    </div>
                    <div class="ccs-dashboard-panels__item govuk-grid-column-one-third">
                      <a class="ccs-dashboard-panels__item-title" href="/noah">
                        Noah
                      </a>
                      <p class="ccs-dashboard-panels__item-description">
                        Noah is not the boss
                      </p>
                    </div>
                    <div class="ccs-dashboard-panels__item govuk-grid-column-one-third">
                      <a class="ccs-dashboard-panels__item-title" href="/lanz">
                        Lanz
                      </a>
                      <p class="ccs-dashboard-panels__item-description">
                        Lanz is not the boss
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        '.to_one_line)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(dashboard_panels_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(dashboard_panels_element[:class]).to eq('ccs-dashboard-panels my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(dashboard_panels_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a width is provided' do
      let(:options) { { width: 'two-thirds' } }

      it 'has the width of two thirds' do
        expect(dashboard_panels_element).to have_css('div.govuk-grid-row > div.govuk-grid-column-two-thirds')
      end
    end

    context 'when considering a panel item' do
      let(:panel_items) do
        [
          {
            title: 'Eunie',
            href: '/eunie',
            description: "Eunie's the boss"
          }.merge(panel_items_options)
        ]
      end
      let(:panel_items_options) { {} }

      context 'when an ID is passed' do
        let(:panel_items_options) { { attributes: { id: 'my-custom-panel-item-id' } } }

        it 'has the id' do
          expect(dashboard_panels_item_element[:id]).to eq('my-custom-panel-item-id')
        end
      end

      context 'when additional classes are passed' do
        let(:panel_items_options) { { classes: 'my-custom-panel-item-class' } }

        it 'does not have the custom class' do
          expect(dashboard_panels_item_element[:class]).to eq('ccs-dashboard-panels__item govuk-grid-column-one-third')
        end
      end

      context 'when additional attributes are passed' do
        let(:panel_items_options) { { attributes: { data: { test: 'hello there' } } } }

        it 'has the additional attributes' do
          expect(dashboard_panels_item_element[:'data-test']).to eq('hello there')
        end
      end

      context 'when a width is provided' do
        let(:panel_items_options) { { width: 'two-thirds' } }

        it 'has the width of two thirds' do
          expect(dashboard_panels_item_element[:class]).to eq('ccs-dashboard-panels__item govuk-grid-column-two-thirds')
        end
      end
    end
  end
end
