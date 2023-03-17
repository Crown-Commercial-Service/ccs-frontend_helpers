# frozen_string_literal: true

require 'ccs/components/govuk/tabs'

RSpec.describe CCS::Components::GovUK::Tabs do
  include_context 'and I have a view context'

  let(:tabs_element) { Capybara::Node::Simple.new(result).find('div.govuk-tabs') }
  let(:tabs_list_elements) { tabs_element.all('li.govuk-tabs__list-item > a') }
  let(:tabs_panel_elements) { tabs_element.all('div.govuk-tabs__panel') }

  describe '.render' do
    let(:govuk_tabs) { described_class.new(items: tabs, title: title, id_prefix: id_prefix, context: view_context, **options) }
    let(:result) { govuk_tabs.render }

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
    let(:id_prefix) { nil }
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
      let(:govuk_tabs) { described_class.new(items: tabs, title: title, id_prefix: id_prefix, context: view_context) }

      it 'correctly formats the HTML with the tabs' do
        expect(tabs_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(tabs_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(tabs_element[:class]).to eq('govuk-tabs my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(tabs_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when the title and id_prefix are not passed' do
      let(:govuk_tabs) { described_class.new(items: tabs, context: view_context, **options) }

      it 'defaults to Contents' do
        expect(tabs_element).to have_css('h2.govuk-tabs__title', text: 'Contents')
      end
    end

    context 'when considering the id' do
      context 'and no panels have one' do
        let(:tabs) do
          [
            {
              label: 'Eunie',
              panel: {
                content: tag.div('Eunie is apparently, and this her words not mine, "the boss"', class: 'my-random-content'),
              }
            },
            {
              label: 'Mio',
              panel: {
                text: 'A delicate yet strong individual with a strong sense for justice',
              }
            },
            {
              label: 'Noah',
              panel: {
                text: 'Keves\' finest fighter but looking for peace',
              }
            },
          ]
        end

        context 'and there is no id prefix' do
          it 'uses the title to form the id for the first panel' do
            expect(tabs_list_elements[0][:href]).to eq '#ouroboros_information-1'
            expect(tabs_panel_elements[0][:id]).to eq 'ouroboros_information-1'
          end

          it 'uses the title to form the id for the second panel' do
            expect(tabs_list_elements[1][:href]).to eq '#ouroboros_information-2'
            expect(tabs_panel_elements[1][:id]).to eq 'ouroboros_information-2'
          end

          it 'uses the title to form the id for the third panel' do
            expect(tabs_list_elements[2][:href]).to eq '#ouroboros_information-3'
            expect(tabs_panel_elements[2][:id]).to eq 'ouroboros_information-3'
          end
        end

        context 'and there is an id prefix' do
          let(:id_prefix) { 'my-id-prefix' }

          it 'uses the id prefix to form the id for the first panel' do
            expect(tabs_list_elements[0][:href]).to eq '#my-id-prefix-1'
            expect(tabs_panel_elements[0][:id]).to eq 'my-id-prefix-1'
          end

          it 'uses the id prefix to form the id for the second panel' do
            expect(tabs_list_elements[1][:href]).to eq '#my-id-prefix-2'
            expect(tabs_panel_elements[1][:id]).to eq 'my-id-prefix-2'
          end

          it 'uses the id prefix to form the id for the third panel' do
            expect(tabs_list_elements[2][:href]).to eq '#my-id-prefix-3'
            expect(tabs_panel_elements[2][:id]).to eq 'my-id-prefix-3'
          end
        end
      end

      context 'and some panels have one' do
        let(:tabs) do
          [
            {
              label: 'Eunie',
              panel: {
                content: tag.div('Eunie is apparently, and this her words not mine, "the boss"', class: 'my-random-content'),
              }
            },
            {
              label: 'Mio',
              panel: {
                text: 'A delicate yet strong individual with a strong sense for justice',
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

        context 'and there is no id prefix' do
          it 'uses the title to form the id for the first panel' do
            expect(tabs_list_elements[0][:href]).to eq '#ouroboros_information-1'
            expect(tabs_panel_elements[0][:id]).to eq 'ouroboros_information-1'
          end

          it 'uses the title to form the id for the second panel' do
            expect(tabs_list_elements[1][:href]).to eq '#ouroboros_information-2'
            expect(tabs_panel_elements[1][:id]).to eq 'ouroboros_information-2'
          end

          it 'uses the id from the third panel' do
            expect(tabs_list_elements[2][:href]).to eq '#noah'
            expect(tabs_panel_elements[2][:id]).to eq 'noah'
          end
        end

        context 'and there is an id prefix' do
          let(:id_prefix) { 'my-id-prefix' }

          it 'uses the id prefix to form the id for the first panel' do
            expect(tabs_list_elements[0][:href]).to eq '#my-id-prefix-1'
            expect(tabs_panel_elements[0][:id]).to eq 'my-id-prefix-1'
          end

          it 'uses the id prefix to form the id for the second panel' do
            expect(tabs_list_elements[1][:href]).to eq '#my-id-prefix-2'
            expect(tabs_panel_elements[1][:id]).to eq 'my-id-prefix-2'
          end

          it 'uses the id from the third panel' do
            expect(tabs_list_elements[2][:href]).to eq '#noah'
            expect(tabs_panel_elements[2][:id]).to eq 'noah'
          end
        end
      end
    end
  end
end
