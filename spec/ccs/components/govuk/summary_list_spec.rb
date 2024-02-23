# frozen_string_literal: true

require 'ccs/components/govuk/summary_list'

RSpec.describe CCS::Components::GovUK::SummaryList do
  include_context 'and I have a view context'

  let(:result) { govuk_summary_list.render }

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

  describe '.render' do
    let(:summary_list_element) { Capybara::Node::Simple.new(result).find('dl.govuk-summary-list') }
    let(:summary_list_row_elements) { summary_list_element.all('div.govuk-summary-list__row') }

    let(:govuk_summary_list) { described_class.new(summary_list_items: summary_list, context: view_context, **options) }

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
                Change
                <span class="govuk-visually-hidden">
                  name
                </span>
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
                Change
                <span class="govuk-visually-hidden">
                  age
                </span>
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
                Change
                <span class="govuk-visually-hidden">
                  nation
                </span>
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
      let(:govuk_summary_list) { described_class.new(summary_list_items: summary_list, context: view_context) }

      it 'correctly formats the HTML with the summary' do
        expect(summary_list_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(summary_list_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(summary_list_element[:class]).to eq('govuk-summary-list my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(summary_list_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when some rows have actions' do
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

      it 'adds the no-actions modifier to the correct rows' do
        expect(summary_list_row_elements[0][:class]).to eq('govuk-summary-list__row')
        expect(summary_list_row_elements[1][:class]).to eq('govuk-summary-list__row govuk-summary-list__row--no-actions')
        expect(summary_list_row_elements[2][:class]).to eq('govuk-summary-list__row')
      end
    end

    context 'when no rows have actions' do
      let(:summary_list) do
        [
          {
            key: {
              text: 'Name'
            },
            value: {
              text: 'Eunie'
            }
          },
          {
            key: {
              text: 'Age'
            },
            value: {
              text: '9th term'
            }
          },
          {
            key: {
              text: 'Nation'
            },
            value: {
              text: 'Keves'
            }
          }
        ]
      end

      it 'adds the no-actions modifier to none of the rows' do
        expect(summary_list_row_elements[0][:class]).to eq('govuk-summary-list__row')
        expect(summary_list_row_elements[1][:class]).to eq('govuk-summary-list__row')
        expect(summary_list_row_elements[2][:class]).to eq('govuk-summary-list__row')
      end
    end

    context 'when some rows have actions without items' do
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
              items: []
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

      it 'adds the no-actions modifier to the correct rows' do
        expect(summary_list_row_elements[0][:class]).to eq('govuk-summary-list__row')
        expect(summary_list_row_elements[1][:class]).to eq('govuk-summary-list__row govuk-summary-list__row--no-actions')
        expect(summary_list_row_elements[2][:class]).to eq('govuk-summary-list__row')
      end
    end

    context 'when all rows have actions without items' do
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
              items: []
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
              items: []
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
              items: []
            }
          }
        ]
      end

      it 'adds the no-actions modifier to none of the rows' do
        expect(summary_list_row_elements[0][:class]).to eq('govuk-summary-list__row')
        expect(summary_list_row_elements[1][:class]).to eq('govuk-summary-list__row')
        expect(summary_list_row_elements[2][:class]).to eq('govuk-summary-list__row')
      end
    end
  end

  describe 'render with a card' do
    let(:summary_card_element) { Capybara::Node::Simple.new(result).find('div.govuk-summary-card') }

    let(:govuk_summary_list) { described_class.new(summary_list_items: summary_list, card: card, context: view_context, **options) }

    let(:card) do
      {
        title: card_title,
        actions: card_actions
      }.merge(card_options)
    end
    let(:card_title) { { text: 'Ouroboros members' } }
    let(:card_actions) do
      {
        items: [
          {
            text: 'Delete memebr',
            href: '/delete-member'
          }
        ]
      }
    end
    let(:card_options) { {} }

    let(:default_html) do
      '
        <div class="govuk-summary-card">
          <div class="govuk-summary-card__title-wrapper">
            <h2 class="govuk-summary-card__title">
              Ouroboros members
            </h2>
            <div class="govuk-summary-card__actions">
              <a class="govuk-link" href="/delete-member">
                Delete memebr
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
                    Change
                    <span class="govuk-visually-hidden">
                      name
                    </span>
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
                    Change
                    <span class="govuk-visually-hidden">
                      age
                    </span>
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
                    Change
                    <span class="govuk-visually-hidden">
                      nation
                    </span>
                  </a>
                </dd>
              </div>
            </dl>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary with the title text and actions' do
        expect(summary_card_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_summary_list) { described_class.new(summary_list_items: summary_list, card: card, context: view_context) }

      it 'correctly formats the HTML with the summary with the title text and actions' do
        expect(summary_card_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:card_options) { { classes: 'my-custom-summary-card-class' } }

      it 'has the custom class' do
        expect(summary_card_element[:class]).to eq('govuk-summary-card my-custom-summary-card-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:card_options) { { attributes: { id: 'my-custom-card-id', data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(summary_card_element[:id]).to eq('my-custom-card-id')
        expect(summary_card_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when there is no title' do
      let(:card_options) { { title: nil } }

      it 'does not have the title' do
        expect(summary_card_element).to have_no_css('.govuk-summary-card__title')
      end
    end

    context 'when there are no action items' do
      let(:card_options) { { actions: nil } }

      it 'does not render any action items' do
        expect(summary_card_element).to have_no_css('.govuk-summary-card__actions')
      end
    end
  end
end
