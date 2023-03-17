# frozen_string_literal: true

require 'ccs/components/ccs/dashboard_section/panel'

RSpec.describe CCS::Components::CCS::DashboardSection::Panel, type: :helper do
  include_context 'and I have a view context'

  let(:dashboard_section_panel_element) { Capybara::Node::Simple.new(result).find('div.ccs-dashboard-section__panel') }

  describe '.render' do
    let(:ccs_dashboard_section_panel) { described_class.new(title: title, href: href, description: description, context: view_context, **options) }
    let(:result) { ccs_dashboard_section_panel.render }

    let(:title) { 'Eunie' }
    let(:href) { '/eunie' }
    let(:description) { "Eunie's the boss" }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="ccs-dashboard-section__panel govuk-grid-column-one-third">
          <a class="ccs-dashboard-section__panel-title" href="/eunie">
            Eunie
          </a>
          <p class="ccs-dashboard-section__panel-description">
            Eunie\'s the boss
          </p>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the dashboard section panel' do
        expect(dashboard_section_panel_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:ccs_dashboard_section_panel) { described_class.new(title: title, href: href, description: description, context: view_context) }

      it 'correctly formats the HTML for the dashboard section panel' do
        expect(dashboard_section_panel_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-panel-id' } } }

      it 'has the id' do
        expect(dashboard_section_panel_element[:id]).to eq('my-custom-panel-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-panel-class' } }

      it 'does not have the custom class' do
        expect(dashboard_section_panel_element[:class]).to eq('ccs-dashboard-section__panel govuk-grid-column-one-third')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(dashboard_section_panel_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a width is provided' do
      let(:options) { { width: 'two-thirds' } }

      it 'has the width of two thirds' do
        expect(dashboard_section_panel_element[:class]).to eq('ccs-dashboard-section__panel govuk-grid-column-two-thirds')
      end
    end
  end
end
