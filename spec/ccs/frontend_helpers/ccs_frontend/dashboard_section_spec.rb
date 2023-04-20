# frozen_string_literal: true

require 'ccs/frontend_helpers/ccs_frontend/dashboard_section'

RSpec.describe CCS::FrontendHelpers::CCSFrontend::DashboardSection, type: :helper do
  include described_class

  let(:dashboard_section_element) { Capybara::Node::Simple.new(result).find('div.ccs-dashboard-section') }

  describe '.ccs_dashboard_section' do
    let(:result) { ccs_dashboard_section(dashboard_section_panels, title_text, **options) }

    let(:dashboard_section_panels) do
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
        <div class="ccs-dashboard-section">
          <div class="govuk-grid-row">
            <div class="govuk-grid-column-full">
              <h2 class="ccs-dashboard-section__heading govuk-heading-m">
                Ouroboros
              </h2>
              <hr class="ccs-dashboard-section__heading-section-break govuk-section-break govuk-section-break--visible">
              <div class="govuk-grid-row ccs-dashboard-section__container">
                <div class="ccs-dashboard-section__panel govuk-grid-column-one-third">
                  <a class="ccs-dashboard-section__panel-title" href="/eunie">
                    Eunie
                  </a>
                  <p class="ccs-dashboard-section__panel-description">
                    Eunie\'s the boss
                  </p>
                </div>
                <div class="ccs-dashboard-section__panel govuk-grid-column-one-third">
                  <a class="ccs-dashboard-section__panel-title" href="/noah">
                    Noah
                  </a>
                  <p class="ccs-dashboard-section__panel-description">
                    Noah is not the boss
                  </p>
                </div>
                <div class="ccs-dashboard-section__panel govuk-grid-column-one-third">
                  <a class="ccs-dashboard-section__panel-title" href="/lanz">
                    Lanz
                  </a>
                  <p class="ccs-dashboard-section__panel-description">
                    Lanz is not the boss
                  </p>
                </div>
              </div>
            </div>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the dashboard section' do
        expect(dashboard_section_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { ccs_dashboard_section(dashboard_section_panels, title_text) }

      it 'correctly formats the HTML for the dashboard section' do
        expect(dashboard_section_element.to_html).to eq(default_html)
      end
    end
  end
end
