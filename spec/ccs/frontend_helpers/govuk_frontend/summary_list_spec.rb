# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/summary_list'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::SummaryList, type: :helper do
  include described_class

  let(:summary_list_element) { Capybara::Node::Simple.new(result).find('dl.govuk-summary-list') }
  let(:summary_list_row_elements) { summary_list_element.all('div.govuk-summary-list__row') }
  let(:summary_list_row_actions) { summary_list_row_elements.first.find('dd.govuk-summary-list__actions') }

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
      let(:result) { govuk_summary_list(summary_list) }

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

    context 'when the rows have classes' do
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
            },
            classes: 'my-custom-row-class'
          }
        ]
      end

      it 'renders the row with the custom class' do
        expect(summary_list_row_elements.first[:class]).to eq('govuk-summary-list__row my-custom-row-class')
      end
    end

    context 'when the key has a custom classes' do
      let(:summary_list) do
        [
          {
            key: {
              text: 'Name',
              classes: 'my-custom-key-class'
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
          }
        ]
      end

      it 'renders the row with the custom class' do
        expect(summary_list_row_elements.first.find('dt.govuk-summary-list__key')[:class]).to eq('govuk-summary-list__key my-custom-key-class')
      end
    end

    context 'when the value has a custom classes' do
      let(:summary_list) do
        [
          {
            key: {
              text: 'Name'
            },
            value: {
              text: 'Eunie',
              classes: 'my-custom-value-class'
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
          }
        ]
      end

      it 'renders the row with the custom class' do
        expect(summary_list_row_elements.first.find('dd.govuk-summary-list__value')[:class]).to eq('govuk-summary-list__value my-custom-value-class')
      end
    end

    context 'when considering actions' do
      context 'and it has custom classes' do
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
                ],
                classes: 'my-custom-actions-class'
              }
            }
          ]
        end

        it 'renders the row with the custom class' do
          expect(summary_list_row_actions[:class]).to eq('govuk-summary-list__actions my-custom-actions-class')
        end
      end

      context 'and an action has custom classes' do
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
                    visually_hidden_text: 'name',
                    classes: 'my-custom-action-class'
                  }
                ]
              }
            }
          ]
        end

        it 'renders the action link with the custom class' do
          expect(summary_list_row_actions.first('a')[:class]).to eq('govuk-link my-custom-action-class')
        end
      end

      context 'and an action has custom attributes' do
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
                    visually_hidden_text: 'name',
                    attributes: {
                      id: 'my-custom-action-id',
                      data: {
                        test: 'hello there'
                      }
                    }
                  }
                ]
              }
            }
          ]
        end

        it 'renders the action link with the custom class' do
          expect(summary_list_row_actions.first('a')[:id]).to eq('my-custom-action-id')
          expect(summary_list_row_actions.first('a')[:'data-test']).to eq('hello there')
        end
      end

      context 'when there are multiple actions' do
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
                    visually_hidden_text: 'name',
                  },
                  {
                    href: '/return-to-cycle',
                    text: 'Return to the cycle'
                  }
                ]
              }
            }
          ]
        end

        it 'renders the action links in a list' do
          expect(summary_list_row_actions.to_html).to eq('
            <dd class="govuk-summary-list__actions">
              <ul class="govuk-summary-list__actions-list">
                <li class="govuk-summary-list__actions-list-item">
                  <a class="govuk-link" href="/change-name">
                    Change
                    <span class="govuk-visually-hidden">
                      name
                    </span>
                  </a>
                </li>
                <li class="govuk-summary-list__actions-list-item">
                  <a class="govuk-link" href="/return-to-cycle">
                    Return to the cycle
                  </a>
                </li>
              </ul>
            </dd>
          '.to_one_line)
        end
      end

      context 'when there are no actions' do
        let(:summary_list) do
          [
            {
              key: {
                text: 'Name'
              },
              value: {
                text: 'Eunie'
              }
            }
          ]
        end

        it 'does not render the actions' do
          expect(summary_list_row_elements.first).not_to have_css('dd.govuk-summary-list__actions')
        end
      end

      context 'when there are no action items' do
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
            }
          ]
        end

        it 'does not render the actions' do
          expect(summary_list_row_elements.first).not_to have_css('dd.govuk-summary-list__actions')
        end
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
  end
end
