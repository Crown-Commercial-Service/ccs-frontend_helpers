# frozen_string_literal: true

require 'ccs/components/govuk/footer'

RSpec.describe CCS::Components::GovUK::Footer do
  include_context 'and I have a view context'

  let(:footer_element) { Capybara::Node::Simple.new(result).find('footer.govuk-footer') }
  let(:footer_content_licence_element) { footer_element.find('span.govuk-footer__licence-description') }
  let(:footer_copyright_element) { footer_element.find('a.govuk-footer__copyright-logo') }
  let(:footer_logo_element) { footer_element.find('div.govuk-width-container > svg') }

  describe '.render' do
    let(:govuk_footer) { described_class.new(context: view_context, **footer_options) }
    let(:result) { govuk_footer.render }

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
      '
        <footer class="govuk-footer">
          <div class="govuk-width-container">
            <div class="govuk-footer__navigation">
              <div class="govuk-footer__section govuk-grid-column-two-thirds">
                <h2 class="govuk-footer__heading govuk-heading-m">
                  My hero Academia
                </h2>
                <ul class="govuk-footer__list">
                  <li class="govuk-footer__list-item">
                    <a class="govuk-footer__link" href="/go">Go</a>
                  </li>
                  <li class="govuk-footer__list-item">
                    <a class="govuk-footer__link" href="/beyond">Beyond</a>
                  </li>
                </ul>
              </div>
              <div class="govuk-footer__section govuk-grid-column-one-third">
                <h2 class="govuk-footer__heading govuk-heading-m">
                  Eunie
                </h2>
                <ul class="govuk-footer__list">
                  <li class="govuk-footer__list-item">
                    <a class="govuk-footer__link" href="/eunies-the-boss">Who is the boss?</a>
                  </li>
                </ul>
              </div>
            </div>
            <hr class="govuk-footer__section-break">
            <div class="govuk-footer__meta">
              <div class="govuk-footer__meta-item govuk-footer__meta-item--grow">
                <h2 class="govuk-visually-hidden">
                  What do the words mean?
                </h2>
                <ul class="govuk-footer__inline-list">
                  <li class="govuk-footer__inline-list-item">
                    <a class="govuk-footer__link" href="/plus">Plus</a>
                  </li>
                  <li class="govuk-footer__inline-list-item">
                    <a class="govuk-footer__link" href="/ultra">Ultra</a>
                  </li>
                </ul>
                <svg class="govuk-footer__licence-logo" aria-hidden="true" focusable="false" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 483.2 195.7" height="17" width="41">
                  <path fill="currentColor" d="M421.5 142.8V.1l-50.7 32.3v161.1h112.4v-50.7zm-122.3-9.6A47.12 47.12 0 0 1 221 97.8c0-26 21.1-47.1 47.1-47.1 16.7 0 31.4 8.7 39.7 21.8l42.7-27.2A97.63 97.63 0 0 0 268.1 0c-36.5 0-68.3 20.1-85.1 49.7A98 98 0 0 0 97.8 0C43.9 0 0 43.9 0 97.8s43.9 97.8 97.8 97.8c36.5 0 68.3-20.1 85.1-49.7a97.76 97.76 0 0 0 149.6 25.4l19.4 22.2h3v-87.8h-80l24.3 27.5zM97.8 145c-26 0-47.1-21.1-47.1-47.1s21.1-47.1 47.1-47.1 47.2 21 47.2 47S123.8 145 97.8 145"></path>
                </svg>
                <span class="govuk-footer__licence-description">
                  All content is available under the
                  <a class="govuk-footer__link" rel="license" href="https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/">Open Government Licence v3.0</a>
                  , except where otherwise stated
                </span>
              </div>
              <div class="govuk-footer__meta-item">
                <a class="govuk-footer__link govuk-footer__copyright-logo" href="https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/">
                  © Crown copyright
                </a>
              </div>
            </div>
          </div>
        </footer>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the footer' do
        expect(footer_element.to_html).to eq(default_html)
      end
    end

    context 'when nothing is sent' do
      let(:govuk_footer) { described_class.new(context: view_context) }

      it 'correctly formats the HTML for the footer without any navigation or meta item lists' do
        expect(footer_element.to_html).to eq('
          <footer class="govuk-footer">
            <div class="govuk-width-container">
              <div class="govuk-footer__meta">
                <div class="govuk-footer__meta-item govuk-footer__meta-item--grow">
                  <svg class="govuk-footer__licence-logo" aria-hidden="true" focusable="false" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 483.2 195.7" height="17" width="41">
                    <path fill="currentColor" d="M421.5 142.8V.1l-50.7 32.3v161.1h112.4v-50.7zm-122.3-9.6A47.12 47.12 0 0 1 221 97.8c0-26 21.1-47.1 47.1-47.1 16.7 0 31.4 8.7 39.7 21.8l42.7-27.2A97.63 97.63 0 0 0 268.1 0c-36.5 0-68.3 20.1-85.1 49.7A98 98 0 0 0 97.8 0C43.9 0 0 43.9 0 97.8s43.9 97.8 97.8 97.8c36.5 0 68.3-20.1 85.1-49.7a97.76 97.76 0 0 0 149.6 25.4l19.4 22.2h3v-87.8h-80l24.3 27.5zM97.8 145c-26 0-47.1-21.1-47.1-47.1s21.1-47.1 47.1-47.1 47.2 21 47.2 47S123.8 145 97.8 145"></path>
                  </svg>
                  <span class="govuk-footer__licence-description">
                    All content is available under the
                    <a class="govuk-footer__link" rel="license" href="https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/">Open Government Licence v3.0</a>
                    , except where otherwise stated
                  </span>
                </div>
                <div class="govuk-footer__meta-item">
                  <a class="govuk-footer__link govuk-footer__copyright-logo" href="https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/">
                    © Crown copyright
                  </a>
                </div>
              </div>
            </div>
          </footer>
        '.to_one_line)
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
        expect(footer_element[:class]).to eq('govuk-footer my-custom-class')
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

    context 'when content_licence is given' do
      let(:options) { { content_licence: 'Here is my content license' } }

      it 'has the container classees on the container div' do
        expect(footer_content_licence_element).to have_content('Here is my content license')
      end
    end

    context 'when copyright is given' do
      let(:options) { { copyright: 'Here is my copyright' } }

      it 'has the container classees on the container div' do
        expect(footer_copyright_element).to have_content('Here is my copyright')
      end
    end

    context 'when rebrand is true' do
      let(:options) { { rebrand: true } }

      it 'has the logo in the container' do
        expect(footer_logo_element[:class]).to eq('govuk-footer__crown')
      end
    end
  end
end
