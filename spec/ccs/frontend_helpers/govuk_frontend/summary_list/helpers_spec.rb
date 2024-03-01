# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/summary_list'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::SummaryList, '#helpers', type: :helper do
  include described_class

  let(:summary_list_element) { Capybara::Node::Simple.new(result).find('dl.govuk-summary-list') }

  describe '.govuk_summary_list' do
    let(:result) { govuk_summary_list(summary_list, **options) }

    let(:summary_list) do
      [
        {
          key: {
            text: 'Name'
          },
          value: {
            text: 'Eunie'
          },
          actions: {
            items: [
              {
                href: '/change-name',
                text: 'Change',
                visually_hidden_text: 'name'
              }
            ]
          }
        },
        {
          key: {
            text: 'Age'
          },
          value: {
            text: '9th term'
          },
          actions: {
            items: [
              {
                href: '/change-age',
                text: 'Change',
                visually_hidden_text: 'age'
              }
            ]
          }
        },
        {
          key: {
            text: 'Nation'
          },
          value: {
            text: 'Keves'
          },
          actions: {
            items: [
              {
                href: '/change-nation',
                text: 'Change',
                visually_hidden_text: 'nation'
              }
            ]
          }
        }
      ]
    end
    let(:options) { {} }

    let(:default_html) do
      '
        <dl class="govuk-summary-list">
          <div class="govuk-summary-list__row">
            <dt class="govuk-summary-list__key">
              Name
            </dt>
            <dd class="govuk-summary-list__value">
              Eunie
            </dd>
            <dd class="govuk-summary-list__actions">
              <a class="govuk-link" href="/change-name">
                Change<span class="govuk-visually-hidden"> name</span>
              </a>
            </dd>
          </div>
          <div class="govuk-summary-list__row">
            <dt class="govuk-summary-list__key">
              Age
            </dt>
            <dd class="govuk-summary-list__value">
              9th term
            </dd>
            <dd class="govuk-summary-list__actions">
              <a class="govuk-link" href="/change-age">
                Change<span class="govuk-visually-hidden"> age</span>
              </a>
            </dd>
          </div>
          <div class="govuk-summary-list__row">
            <dt class="govuk-summary-list__key">
              Nation
            </dt>
            <dd class="govuk-summary-list__value">
              Keves
            </dd>
            <dd class="govuk-summary-list__actions">
              <a class="govuk-link" href="/change-nation">
                Change<span class="govuk-visually-hidden"> nation</span>
              </a>
            </dd>
          </div>
        </dl>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary' do
        expect(summary_list_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_summary_list(summary_list) }

      it 'correctly formats the HTML with the summary' do
        expect(summary_list_element.to_html).to eq(default_html)
      end
    end

    context 'when a card is present' do
      let(:summary_card_element) { Capybara::Node::Simple.new(result).find('div.govuk-summary-card') }
      let(:summary_card_title_element) { summary_card_element.find('.govuk-summary-card__title') }
      let(:summary_card_actions) { summary_card_element.find('.govuk-summary-card__actions') }

      let(:options) do
        {
          card: {
            title: {
              text: 'Ouroboros members'
            },
            actions: {
              items: [
                {
                  text: 'Delete memebr',
                  href: '/delete-member'
                }
              ]
            }
          }
        }
      end

      context 'when the default attributes are sent' do
        it 'correctly formats the HTML with the summary with the title text and actions' do
          expect(summary_card_element.to_html).to eq('
            <div class="govuk-summary-card">
              <div class="govuk-summary-card__title-wrapper">
                <h2 class="govuk-summary-card__title">
                  Ouroboros members
                </h2>
                <div class="govuk-summary-card__actions">
                  <a class="govuk-link" href="/delete-member">
                    Delete memebr<span class="govuk-visually-hidden"> (Ouroboros members)</span>
                  </a>
                </div>
              </div>
              <div class="govuk-summary-card__content">
                <dl class="govuk-summary-list">
                  <div class="govuk-summary-list__row">
                    <dt class="govuk-summary-list__key">
                      Name
                    </dt>
                    <dd class="govuk-summary-list__value">
                      Eunie
                    </dd>
                    <dd class="govuk-summary-list__actions">
                      <a class="govuk-link" href="/change-name">
                        Change<span class="govuk-visually-hidden"> name (Ouroboros members)</span>
                      </a>
                    </dd>
                  </div>
                  <div class="govuk-summary-list__row">
                    <dt class="govuk-summary-list__key">
                      Age
                    </dt>
                    <dd class="govuk-summary-list__value">
                      9th term
                    </dd>
                    <dd class="govuk-summary-list__actions">
                      <a class="govuk-link" href="/change-age">
                        Change<span class="govuk-visually-hidden"> age (Ouroboros members)</span>
                      </a>
                    </dd>
                  </div>
                  <div class="govuk-summary-list__row">
                    <dt class="govuk-summary-list__key">
                      Nation
                    </dt>
                    <dd class="govuk-summary-list__value">
                      Keves
                    </dd>
                    <dd class="govuk-summary-list__actions">
                      <a class="govuk-link" href="/change-nation">
                        Change<span class="govuk-visually-hidden"> nation (Ouroboros members)</span>
                      </a>
                    </dd>
                  </div>
                </dl>
              </div>
            </div>
          '.to_one_line)
        end
      end
    end
  end
end
