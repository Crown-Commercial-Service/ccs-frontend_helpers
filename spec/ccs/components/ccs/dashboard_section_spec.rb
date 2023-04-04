# frozen_string_literal: true

require 'ccs/components/ccs/dashboard_section'

RSpec.describe CCS::Components::CCS::DashboardSection do
  include_context 'and I have a view context'

  let(:dashboard_section_element) { Capybara::Node::Simple.new(result).find('div.ccs-dashboard-section') }

  describe '.render' do
    let(:ccs_dashboard_section) { described_class.new(dashboard_section_panels: dashboard_section_panels, title_text: title_text, context: view_context, **options) }
    let(:result) { ccs_dashboard_section.render }

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
              <div class="ccs-dashboard-section__container">
                <div class="govuk-grid-row">
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
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the dashboard section' do
        expect(dashboard_section_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:ccs_dashboard_section) { described_class.new(dashboard_section_panels: dashboard_section_panels, title_text: title_text, context: view_context) }

      it 'correctly formats the HTML for the dashboard section' do
        expect(dashboard_section_element.to_html).to eq(default_html)
      end
    end

    context 'when there is no title text' do
      let(:ccs_dashboard_section) { described_class.new(dashboard_section_panels: dashboard_section_panels, context: view_context, **options) }

      it 'correctly formats the HTML for the dashboard section without the title text' do
        expect(dashboard_section_element.to_html).to eq('
          <div class="ccs-dashboard-section">
            <div class="govuk-grid-row">
              <div class="govuk-grid-column-full">
                <div class="ccs-dashboard-section__container">
                  <div class="govuk-grid-row">
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
          </div>
        '.to_one_line)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(dashboard_section_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(dashboard_section_element[:class]).to eq('ccs-dashboard-section my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(dashboard_section_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a width is provided' do
      let(:options) { { width: 'two-thirds' } }

      it 'has the width of two thirds' do
        expect(dashboard_section_element).to have_css('div.govuk-grid-row > div.govuk-grid-column-two-thirds')
      end
    end
  end
end
