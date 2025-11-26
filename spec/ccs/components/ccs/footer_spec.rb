# frozen_string_literal: true

require 'ccs/components/ccs/footer'

RSpec.describe CCS::Components::CCS::Footer do
  include_context 'and I have a view context'
  include_context 'and I have created the CCS logo HTML'

  let(:footer_element) { Capybara::Node::Simple.new(result).find('footer.ccs-footer') }
  let(:footer_navigation_element) { footer_element.find('div.ccs-footer__navigation') }
  let(:footer_navigation_item_element) { footer_navigation_element.first('li.ccs-footer__list-item > a') }
  let(:footer_meta_element) { footer_element.find('div.ccs-footer__meta-item.ccs-footer__meta-item--grow') }
  let(:footer_meta_item_element) { footer_meta_element.first('li.ccs-footer__inline-list-item > a') }
  let(:footer_content_licence_element) { footer_element.find('span.ccs-footer__licence-description') }
  let(:footer_copyright_element) { footer_element.find('div.ccs-footer__copyright') }

  describe '.render' do
    let(:ccs_footer) { described_class.new(context: view_context, **footer_options) }
    let(:result) { ccs_footer.render }

    let(:footer_options) do
      {
        navigation: navigation_items,
        meta: meta
      }.merge(options)
    end

    let(:navigation_items) do
      [
        {
          title: 'My hero Academia',
          width: 'two-thirds',
          items: [
            {
              text: 'Go',
              href: '/go'
            },
            {
              text: 'Beyond',
              href: '/beyond'
            }
          ]
        },
        {
          title: 'Eunie',
          width: 'one-third',
          items: [
            {
              text: 'Who is the boss?',
              href: '/eunies-the-boss'
            }
          ]
        }
      ]
    end
    let(:meta) do
      {
        visually_hidden_title: 'What do the words mean?',
        items: [
          {
            text: 'Plus',
            href: '/plus'
          },
          {
            text: 'Ultra',
            href: '/ultra'
          }
        ]
      }
    end
    let(:options) { {} }

    let(:default_html) do
      "
        <footer class=\"ccs-footer\">
          <div class=\"govuk-width-container\">
            <div class=\"ccs-footer__navigation\">
              <div class=\"ccs-footer__section govuk-grid-column-two-thirds\">
                <h2 class=\"ccs-footer__heading govuk-heading-m\">
                  My hero Academia
                </h2>
                <ul class=\"ccs-footer__list\">
                  <li class=\"ccs-footer__list-item\">
                    <a class=\"ccs-footer__link\" href=\"/go\">
                      Go
                    </a>
                  </li>
                  <li class=\"ccs-footer__list-item\">
                    <a class=\"ccs-footer__link\" href=\"/beyond\">
                      Beyond
                    </a>
                  </li>
                </ul>
              </div>
              <div class=\"ccs-footer__section govuk-grid-column-one-third\">
                <h2 class=\"ccs-footer__heading govuk-heading-m\">
                  Eunie
                </h2>
                <ul class=\"ccs-footer__list\">
                  <li class=\"ccs-footer__list-item\">
                    <a class=\"ccs-footer__link\" href=\"/eunies-the-boss\">
                      Who is the boss?
                    </a>
                  </li>
                </ul>
              </div>
            </div>
            <hr class=\"ccs-footer__section-break\">
            <div class=\"ccs-footer__meta\">
              <div class=\"ccs-footer__meta-item ccs-footer__meta-item--grow\">
                <h2 class=\"govuk-visually-hidden\">
                  What do the words mean?
                </h2>
                <ul class=\"ccs-footer__inline-list ccs-footer__inline-list--bottom\">
                  <li class=\"ccs-footer__inline-list-item\">
                    <a class=\"ccs-footer__link\" href=\"/plus\">
                      Plus
                    </a>
                  </li>
                  <li class=\"ccs-footer__inline-list-item\">
                    <a class=\"ccs-footer__link\" href=\"/ultra\">
                      Ultra
                    </a>
                  </li>
                </ul>
              </div>
              <div class=\"ccs-footer__meta-item\">
                <div class=\"ccs-footer__copyright\">
                  <a class=\"ccs-footer__link\" href=\"https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/\">
                    <div class=\"ccs-footer__logo\">
                      #{ccs_logo_crown_html}
                    </div>
                    © Crown copyright
                  </a>
                </div>
              </div>
            </div>
          </div>
        </footer>
      ".to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the footer' do
        expect(footer_element.to_html).to eq(default_html)
      end
    end

    context 'when nothing is sent' do
      let(:ccs_footer) { described_class.new(context: view_context) }

      it 'correctly formats the HTML for the footer without any navigation or meta item lists' do
        expect(footer_element.to_html).to eq("
          <footer class=\"ccs-footer\">
            <div class=\"govuk-width-container\">
              <div class=\"ccs-footer__meta\">
                <div class=\"ccs-footer__meta-item ccs-footer__meta-item--grow\">
                </div>
                <div class=\"ccs-footer__meta-item\">
                  <div class=\"ccs-footer__copyright\">
                    <a class=\"ccs-footer__link\" href=\"https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/\">
                      <div class=\"ccs-footer__logo\">
                        #{ccs_logo_crown_html}
                      </div>
                      © Crown copyright
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </footer>
        ".to_one_line)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(footer_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(footer_element[:class]).to eq('ccs-footer my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(footer_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a container_classes' do
      let(:options) { { container_classes: 'my-container-class' } }

      it 'has the container classees on the container div' do
        expect(footer_element).to have_css('div.govuk-width-container.my-container-class')
      end
    end

    context 'when copyright is given' do
      let(:options) { { copyright: 'Here is my copyright' } }

      it 'has the container classees on the container div' do
        expect(footer_copyright_element).to have_content('Here is my copyright')
      end
    end
  end
end
