# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/tabs'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tabs, type: :helper do
  include described_class

  let(:tabs_element) { Capybara::Node::Simple.new(result).find('div.govuk-tabs') }
  let(:tabs_list_elements) { tabs_element.all('li.govuk-tabs__list-item > a') }
  let(:tabs_panel_elements) { tabs_element.all('div.govuk-tabs__panel') }

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
          <ul class="govuk-tabs__lis">
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

    context 'when the title is not passed' do
      let(:result) { govuk_tabs(tabs, **options) }

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
          let(:options) { { id_prefix: 'my-id-prefix' } }

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
          let(:options) { { id_prefix: 'my-id-prefix' } }

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

    context 'when looking at a list item' do
      let(:tabs) do
        [
          {
            label: 'Eunie',
            panel: {
              content: tag.div('Eunie is apparently, and this her words not mine, "the boss"', class: 'my-random-content'),
            }
          }.merge(list_item_options)
        ]
      end

      context 'when an ID is passed' do
        let(:list_item_options) { { attributes: { id: 'my-custom-list-item-id' } } }

        it 'has the id' do
          expect(tabs_list_elements[0][:id]).to eq 'my-custom-list-item-id'
        end
      end

      context 'when additional classes are passed' do
        let(:list_item_options) { { attributes: { class: 'my-custom-list-item-class' } } }

        it 'does not have the custom class' do
          expect(tabs_list_elements[0][:class]).to eq 'govuk-tabs__tab'
        end
      end

      context 'when additional attributes are passed' do
        let(:list_item_options) { { attributes: { data: { test: 'hello there' } } } }

        it 'has the additional attributes' do
          expect(tabs_list_elements[0][:'data-test']).to eq('hello there')
        end
      end
    end

    context 'when look at a pane; item' do
      let(:tabs) do
        [
          {
            label: 'Eunie',
            panel: {
              content: tag.div('Eunie is apparently, and this her words not mine, "the boss"', class: 'my-random-content'),
            }.merge(panel_item_options)
          }
        ]
      end

      context 'when additional classes are passed' do
        let(:panel_item_options) { { attributes: { class: 'my-custom-panel-item-class' } } }

        it 'does not have the custom class' do
          expect(tabs_panel_elements[0][:class]).to eq 'govuk-tabs__panel'
        end
      end

      context 'when additional attributes are passed' do
        let(:panel_item_options) { { attributes: { data: { test: 'hello there' } } } }

        it 'has the additional attributes' do
          expect(tabs_panel_elements[0][:'data-test']).to eq('hello there')
        end
      end
    end
  end
end
