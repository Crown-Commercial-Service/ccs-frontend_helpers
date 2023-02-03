# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/cookie_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::CookieBanner, type: :helper do
  include described_class

  let(:cookie_banner_element) { Capybara::Node::Simple.new(result).find('div.govuk-cookie-banner') }
  let(:cookie_banner_messages_elements) { cookie_banner_element.all('div.govuk-cookie-banner__message', visible: false) }
  let(:cookie_banner_messages_element) { cookie_banner_messages_elements.first }
  let(:cookie_banner_message_actions) { cookie_banner_messages_element.find('div.govuk-button-group') }

  describe '.govuk_cookie_banner' do
    let(:result) { govuk_cookie_banner(messages, **options) }

    let(:messages) do
      [
        {
          heading_text: 'Cookies for Ouroboros',
          text: 'These are the cookies for ouroboros',
          actions: [
            {
              text: 'Accept ouroboros cookies',
              attributes: {
                name: 'cookies',
                value: 'accept'
              },
            },
            {
              text: 'Reject ouroboros cookies',
              attributes: {
                name: 'cookies',
                value: 'reject'
              },
            },
            {
              text: 'View ouroboros cookies',
              href: '#'
            }
          ]
        }.merge(message_options)
      ]
    end
    let(:options) { {} }
    let(:message_options) { {} }

    let(:default_html) do
      '
      <div class="govuk-cookie-banner" data-nosnippet="true" role="region" aria-label="Cookie banner">
        <div class="govuk-cookie-banner__message govuk-width-container">
          <div class="govuk-grid-row">
            <div class="govuk-grid-column-two-thirds">
              <h2 class="govuk-cookie-banner__heading govuk-heading-m">Cookies for Ouroboros</h2>
              <div class="govuk-cookie-banner__content">
                <p class="govuk-body">These are the cookies for ouroboros</p>
              </div>
            </div>
          </div>
          <div class="govuk-button-group">
            <button name="cookies" type="submit" value="accept" class="govuk-button" data-module="govuk-button">
              Accept ouroboros cookies
            </button>
            <button name="cookies" type="submit" value="reject" class="govuk-button" data-module="govuk-button">
              Reject ouroboros cookies
            </button>
            <a class="govuk-link" href="#">View ouroboros cookies</a>
          </div>
        </div>
      </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the heading text' do
        expect(cookie_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_cookie_banner(messages) }

      it 'correctly formats the HTML with the heading text' do
        expect(cookie_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(cookie_banner_element[:class]).to eq('govuk-cookie-banner my-custom-class')
      end
    end

    context 'when an aria-label is passed' do
      let(:options) { { attributes: { aria: { label: 'My custom aria label' } } } }

      it 'has the custom aria label' do
        expect(cookie_banner_element[:'aria-label']).to eq('My custom aria label')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { id: 'my-custom-id', data: { 'disable-auto-focus': 'true' } } } }

      it 'has the additional attributes' do
        expect(cookie_banner_element[:id]).to eq('my-custom-id')
        expect(cookie_banner_element[:'data-disable-auto-focus']).to eq('true')
        expect(cookie_banner_element[:'data-nosnippet']).to eq('true')
      end
    end

    context 'when considering a message' do
      context 'and additional classes are passed' do
        let(:message_options) { { classes: 'my-custom-message-class' } }

        it 'has the custom class' do
          expect(cookie_banner_messages_element[:class]).to eq('govuk-cookie-banner__message govuk-width-container my-custom-message-class')
        end
      end

      context 'and a role is passed' do
        let(:message_options) { { attributes: { role: 'alert' } } }

        it 'has the role' do
          expect(cookie_banner_messages_element[:role]).to eq('alert')
        end
      end

      context 'and additional attributes are passed' do
        let(:message_options) { { attributes: { id: 'my-custom-message-id', data: { test: 'hello-there' } } } }

        it 'has the additional attributes' do
          expect(cookie_banner_messages_element[:id]).to eq('my-custom-message-id')
          expect(cookie_banner_messages_element[:'data-test']).to eq('hello-there')
        end
      end

      context 'when content is passed' do
        let(:messages) do
          [
            {
              content: tag.div('Here is the content', class: 'my-random-content'),
            }
          ]
        end

        it 'renders the content' do
          expect(cookie_banner_messages_element).to have_css('div.my-random-content', text: 'Here is the content')
        end
      end

      context 'when content and text is passed' do
        let(:messages) do
          [
            {
              text: 'Here is the text',
              content: tag.div('Here is the content', class: 'my-random-content'),
            }
          ]
        end

        it 'renders the content only' do
          expect(cookie_banner_messages_element).not_to have_css('p.govuk-body', text: 'Here is the text')
          expect(cookie_banner_messages_element).to have_css('div.my-random-content', text: 'Here is the content')
        end
      end

      context 'when there is no heading or actions' do
        let(:messages) do
          [
            {
              text: 'These are the cookies for ouroboros',
            }
          ]
        end

        it 'only renders the message text' do
          expect(cookie_banner_messages_element.to_html).to eq('
            <div class="govuk-cookie-banner__message govuk-width-container">
              <div class="govuk-grid-row">
                <div class="govuk-grid-column-two-thirds">
                  <div class="govuk-cookie-banner__content">
                    <p class="govuk-body">These are the cookies for ouroboros</p>
                  </div>
                </div>
              </div>
            </div>
          '.to_one_line)
        end
      end
    end

    # rubocop:disable RSpec/NestedGroups

    context 'when considering an action' do
      let(:messages) do
        [
          {
            heading_text: 'Cookies for Ouroboros',
            text: 'These are the cookies for ouroboros',
            actions: [
              {
                text: 'Accept ouroboros cookies'
              }.merge!(action_options)
            ]
          }
        ]
      end
      let(:action_options) { {} }

      context 'and there is a href' do
        let(:action_options) { { href: '/go-here' } }

        context 'and the type is button' do
          let(:action_button) { cookie_banner_message_actions.find('a.govuk-button') }

          let(:action_options) { super().merge({ attributes: { type: :button } }) }

          it 'renders a link with button classes' do
            expect(action_button.to_html).to eq('<a type="button" class="govuk-button" data-module="govuk-button" role="button" draggable="false" href="/go-here">Accept ouroboros cookies</a>')
          end

          context 'when additional classes are passed' do
            let(:action_options) { super().merge({ classes: 'my-custom-action-class' }) }

            it 'has the custom class' do
              expect(action_button[:class]).to eq('govuk-button my-custom-action-class')
            end
          end

          context 'when additional attributes are passed' do
            let(:action_options) { super().merge({ attributes: { type: :button, id: 'my-custom-action-id', data: { test: 'hello there' } } }) }

            it 'has the additional attributes' do
              expect(action_button[:id]).to eq('my-custom-action-id')
              expect(action_button[:'data-test']).to eq('hello there')
            end
          end
        end

        context 'and there is no type' do
          let(:action_link) { cookie_banner_message_actions.find('a.govuk-link') }

          it 'renders a link' do
            expect(action_link.to_html).to eq('<a class="govuk-link" href="/go-here">Accept ouroboros cookies</a>')
          end

          context 'when additional classes are passed' do
            let(:action_options) { super().merge({ classes: 'my-custom-action-class' }) }

            it 'has the custom class' do
              expect(action_link[:class]).to eq('govuk-link my-custom-action-class')
            end
          end

          context 'when additional attributes are passed' do
            let(:action_options) { super().merge({ attributes: { id: 'my-custom-action-id', data: { test: 'hello there' } } }) }

            it 'has the additional attributes' do
              expect(action_link[:id]).to eq('my-custom-action-id')
              expect(action_link[:'data-test']).to eq('hello there')
            end
          end
        end
      end

      context 'and there is not a href' do
        context 'and the type is button' do
          let(:action_button) { cookie_banner_message_actions.find('button.govuk-button') }

          let(:action_options) { super().merge({ attributes: { type: :button } }) }

          it 'renders a button' do
            expect(action_button.to_html).to eq('<button name="button" type="button" class="govuk-button" data-module="govuk-button">Accept ouroboros cookies</button>')
          end

          context 'when additional classes are passed' do
            let(:action_options) { super().merge({ classes: 'my-custom-action-class' }) }

            it 'has the custom class' do
              expect(action_button[:class]).to eq('govuk-button my-custom-action-class')
            end
          end

          context 'when additional attributes are passed' do
            let(:action_options) { super().merge({ attributes: { type: :button, id: 'my-custom-action-id', data: { test: 'hello there' } } }) }

            it 'has the additional attributes' do
              expect(action_button[:id]).to eq('my-custom-action-id')
              expect(action_button[:'data-test']).to eq('hello there')
            end
          end
        end

        context 'and there is no type' do
          let(:action_button) { cookie_banner_message_actions.find('button.govuk-button') }

          it 'renders a submit button' do
            expect(action_button.to_html).to eq('<button name="button" type="submit" class="govuk-button" data-module="govuk-button">Accept ouroboros cookies</button>')
          end

          context 'when additional classes are passed' do
            let(:action_options) { super().merge({ classes: 'my-custom-action-class' }) }

            it 'has the custom class' do
              expect(action_button[:class]).to eq('govuk-button my-custom-action-class')
            end
          end

          context 'when additional attributes are passed' do
            let(:action_options) { super().merge({ attributes: { id: 'my-custom-action-id', data: { test: 'hello there' } } }) }

            it 'has the additional attributes' do
              expect(action_button[:id]).to eq('my-custom-action-id')
              expect(action_button[:'data-test']).to eq('hello there')
            end
          end
        end
      end
    end

    # rubocop:enable RSpec/NestedGroups

    context 'and there are multiple messages' do
      let(:messages) do
        [
          {
            heading_text: 'Cookies for Ouroboros',
            text: 'These are the cookies for ouroboros',
            actions: [
              {
                text: 'Accept ouroboros cookies',
                attributes: {
                  name: 'cookies',
                  value: 'accept'
                },
              },
              {
                text: 'Reject ouroboros cookies',
                attributes: {
                  name: 'cookies',
                  value: 'reject'
                },
              },
              {
                text: 'View ouroboros cookies',
                href: '#'
              }
            ]
          },
          {
            html: 'You’ve accepted additional cookies',
            actions: [
              {
                text: 'Hide cookie message',
              }
            ],
            attributes: {
              hidden: true
            }
          },
          {
            html: 'You’ve rejected additional cookies',
            actions: [
              {
                text: 'Hide cookie message',
              }
            ],
            attributes: {
              hidden: true
            }
          }
        ]
      end

      it 'creates three message sections' do
        expect(cookie_banner_messages_elements.length).to eq(3)
      end

      it 'the first section is visible' do
        expect(cookie_banner_messages_elements[0]).to be_visible
      end

      it 'the second and third section is not visible' do
        expect(cookie_banner_messages_elements[1]).not_to be_visible
        expect(cookie_banner_messages_elements[2]).not_to be_visible
      end
    end
  end
end
