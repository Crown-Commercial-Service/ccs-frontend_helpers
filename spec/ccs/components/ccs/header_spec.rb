# frozen_string_literal: true

require 'ccs/components/ccs/header'

RSpec.describe CCS::Components::CCS::Header, type: :helper do
  include_context 'and I have a view context'
  include_context 'and I have created the CCS logo HTML'

  let(:header_element) { Capybara::Node::Simple.new(result).find('header.ccs-header') }
  let(:header_container_element) { header_element.find('div.ccs-header__container') }

  describe '.render' do
    let(:ccs_header) { described_class.new(context: view_context, **options) }
    let(:result) { ccs_header.render }

    let(:options) { { homepage_url: 'https://www.crowncommercial.gov.uk/my-hero-academia' } }

    let(:default_html) do
      "
        <header class=\"ccs-header\" data-module=\"ccs-header\">
          <div class=\"ccs-header__container govuk-width-container\">
            <div class=\"ccs-header__logo\">
              <a class=\"ccs-header__link ccs-header__link--homepage\" aria-label=\"Crown Commercial Service\" href=\"https://www.crowncommercial.gov.uk/my-hero-academia\">
                #{ccs_logo_html}
              </a>
            </div>
          </div>
        </header>
      ".to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the header' do
        expect(header_element.to_html).to eq(default_html)
      end
    end

    context 'when no service, naviagtion or container options are sent' do
      let(:ccs_header) { described_class.new(context: view_context) }

      it 'correctly formats the HTML with the hint text' do
        expect(header_element.to_html).to eq("
          <header class=\"ccs-header\" data-module=\"ccs-header\">
            <div class=\"ccs-header__container govuk-width-container\">
              <div class=\"ccs-header__logo\">
                <a class=\"ccs-header__link ccs-header__link--homepage\" aria-label=\"Crown Commercial Service\" href=\"https://www.crowncommercial.gov.uk\">
                  #{ccs_logo_html}
                </a>
              </div>
            </div>
          </header>
        ".to_one_line)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(header_element[:class]).to eq('ccs-header my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' }, test: 'General Kenobi' } } }

      it 'has the additional attributes' do
        expect(header_element[:'data-module']).to eq('ccs-header')
        expect(header_element[:'data-test']).to eq('hello there')
        expect(header_element[:test]).to eq('General Kenobi')
      end
    end

    context 'when custom container classes are passed' do
      let(:options) { { container_classes: 'ccs-header__container--full-width' } }

      it 'has the custom class' do
        expect(header_container_element[:class]).to eq('ccs-header__container ccs-header__container--full-width')
      end
    end
  end
end
