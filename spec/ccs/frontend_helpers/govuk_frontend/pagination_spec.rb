# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/pagination'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Pagination, type: :helper do
  include described_class

  let(:pagination_section) { Capybara::Node::Simple.new(result).find('nav.govuk-pagination') }
  let(:pagination_next_element) { Capybara::Node::Simple.new(result).find('div.govuk-pagination__next') }
  let(:pagination_prev_element) { Capybara::Node::Simple.new(result).find('div.govuk-pagination__prev') }
  let(:pagination_item_element) { Capybara::Node::Simple.new(result).find('li.govuk-pagination__item:nth-of-type(2)') }
  let(:pagination_current_item_element) { Capybara::Node::Simple.new(result).find('li.govuk-pagination__item:nth-of-type(3)') }
  let(:pagination_ellipsis_item_element) { Capybara::Node::Simple.new(result).find('li.govuk-pagination__item--ellipses') }

  let(:options) do
    {
      next: {
        href: '/next'
      },
      previous: {
        href: '/previous'
      },
      items: [
        {
          type: :ellipsis
        },
        {
          type: :number,
          href: '/?page=3',
          number: 3
        },
        {
          type: :number,
          href: '/?page=4',
          number: 4,
          current: true
        },
        {
          type: :number,
          href: '/?page=5',
          number: 5
        },
        {
          type: :ellipsis
        }
      ]
    }
  end

  describe '.govuk_pagination' do
    let(:result) { govuk_pagination(**options) }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with pagination' do
        expect(pagination_section.to_html).to eq('
          <nav class="govuk-pagination" role="navigation" aria-label="results">
            <div class="govuk-pagination__prev">
              <a class="govuk-link govuk-pagination__link" rel="prev" href="/previous">
                <svg class="govuk-pagination__icon govuk-pagination__icon--prev" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z"></path>
                </svg>
                <span class="govuk-pagination__link-title">
                  Previous
                </span>
              </a>
            </div>
            <ul class="govuk-pagination__list">
              <li class="govuk-pagination__item govuk-pagination__item--ellipses">
                ⋯
              </li>
              <li class="govuk-pagination__item">
                <a class="govuk-link govuk-pagination__link" aria-label="Page 3" href="/?page=3">
                  3
                </a>
              </li>
              <li class="govuk-pagination__item govuk-pagination__item--current">
                <a class="govuk-link govuk-pagination__link" aria-label="Page 4" aria-current="page" href="/?page=4">
                  4
                </a>
              </li>
              <li class="govuk-pagination__item">
                <a class="govuk-link govuk-pagination__link" aria-label="Page 5" href="/?page=5">
                  5
                </a>
              </li>
              <li class="govuk-pagination__item govuk-pagination__item--ellipses">
                ⋯
              </li>
            </ul>
            <div class="govuk-pagination__next">
              <a class="govuk-link govuk-pagination__link" rel="next" href="/next">
                <span class="govuk-pagination__link-title">
                  Next
                </span>
                <svg class="govuk-pagination__icon govuk-pagination__icon--next" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z"></path>
                </svg>
              </a>
            </div>
          </nav>
        '.to_one_line)
      end

      context 'when additional classes are passed' do
        let(:options) { super().merge({ classes: 'my-custom-class' }) }

        it 'has the custom class' do
          expect(pagination_section[:class]).to eq('govuk-pagination my-custom-class')
        end
      end

      context 'when additional attributes are passed' do
        let(:options) { { attributes: { aria: { label: 'custom aria label' }, data: { test: 'hello there' }, id: 'custom-id' } } }

        it 'has the additional attributes' do
          expect(pagination_section[:'aria-label']).to eq('custom aria label')
          expect(pagination_section[:'data-test']).to eq('hello there')
          expect(pagination_section[:id]).to eq('custom-id')
        end
      end

      context 'when custom text is passed' do
        let(:options) do
          super().merge(
            {
              next: {
                href: '/next',
                text: 'Go to the next page'
              },
              previous: {
                href: '/previous',
                text: 'Go to the previous page'
              }
            }
          )
        end

        it 'has the custom text for next and previous' do
          expect(pagination_next_element).to have_content('Go to the next page')
          expect(pagination_prev_element).to have_content('Go to the previous page')
        end
      end

      context 'and label text is passed' do
        let(:options) do
          super().merge(
            {
              next: {
                href: '/next',
                lable_text: 'Go Beyond, Plus Ultra!'
              },
              previous: {
                href: '/previous',
                lable_text: 'Jet fire burn'
              }
            }
          )
        end

        it 'does not render the label text' do
          expect(pagination_prev_element).not_to have_content('Previous:Jet fire burn')
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end
      end

      context 'when there is only the previous link and no next' do
        let(:options) do
          super().merge(
            {
              next: nil
            }
          )
        end

        it 'does not render the next element' do
          expect(pagination_section).not_to have_css('div.govuk-pagination__next')
        end
      end

      context 'when there is only the next link and no previous' do
        let(:options) do
          super().merge(
            {
              previous: nil
            }
          )
        end

        it 'does not render the next element' do
          expect(pagination_section).not_to have_css('div.govuk-pagination__previous')
        end
      end

      context 'when there are no items' do
        let(:options) do
          super().merge(
            {
              items: nil
            }
          )
        end

        it 'correctly formats the HTML with pagination in a block' do
          expect(pagination_section.to_html).to eq('
            <nav class="govuk-pagination govuk-pagination--block" role="navigation" aria-label="results">
              <div class="govuk-pagination__prev">
                <a class="govuk-link govuk-pagination__link" rel="prev" href="/previous">
                  <svg class="govuk-pagination__icon govuk-pagination__icon--prev" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                    <path d="m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z"></path>
                  </svg>
                  <span class="govuk-pagination__link-title govuk-pagination__link-title--decorated">
                    Previous
                  </span>
                </a>
              </div>
              <div class="govuk-pagination__next">
                <a class="govuk-link govuk-pagination__link" rel="next" href="/next">
                  <svg class="govuk-pagination__icon govuk-pagination__icon--next" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                    <path d="m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z"></path>
                  </svg>
                  <span class="govuk-pagination__link-title govuk-pagination__link-title--decorated">
                    Next
                  </span>
                </a>
              </div>
            </nav>
          '.to_one_line)
        end

        context 'and label text is passed' do
          let(:options) do
            super().merge(
              {
                next: {
                  href: '/next',
                  lable_text: 'Go Beyond, Plus Ultra!'
                },
                previous: {
                  href: '/previous',
                  lable_text: 'Jet fire burn'
                }
              }
            )
          end

          it 'renders the label text for the next and previous links' do
            expect(pagination_prev_element).to have_content('Previous:Jet fire burn')
            expect(pagination_next_element).to have_content('Next:Go Beyond, Plus Ultra!')
          end
        end
      end
    end
  end

  describe '.govuk_pagination with form' do
    let(:result) { govuk_pagination(**options, form: form) }

    let(:form) do
      ActionView::Helpers::FormBuilder.new(
        TestModel.model_name.singular,
        TestModel.new,
        TestView.new(:lookup_context, [], :controller),
        {}
      )
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with pagination' do
        expect(pagination_section.to_html).to eq('
          <nav class="govuk-pagination" role="navigation" aria-label="results">
            <div class="govuk-pagination__prev">
              <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination--button_as_link" rel="prev">
                <svg class="govuk-pagination__icon govuk-pagination__icon--prev" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z"></path>
                </svg>
                <span class="govuk-pagination__link-title">
                  Previous
                </span>
              </button>
            </div>
            <ul class="govuk-pagination__list">
              <li class="govuk-pagination__item govuk-pagination__item--ellipses">
                ⋯
              </li>
              <li class="govuk-pagination__item">
                <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination-number--button_as_link" aria-label="Page 3">
                  3
                </button>
              </li>
              <li class="govuk-pagination__item govuk-pagination__item--current">
                <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination-number--button_as_link" aria-label="Page 4" aria-current="page">
                  4
                </button>
              </li>
              <li class="govuk-pagination__item">
                <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination-number--button_as_link" aria-label="Page 5">
                  5
                </button>
              </li>
              <li class="govuk-pagination__item govuk-pagination__item--ellipses">
                ⋯
              </li>
            </ul>
            <div class="govuk-pagination__next">
              <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination--button_as_link" rel="next">
                <span class="govuk-pagination__link-title">
                  Next
                </span>
                <svg class="govuk-pagination__icon govuk-pagination__icon--next" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z"></path>
                </svg>
              </button>
            </div>
          </nav>
        '.to_one_line)
      end

      context 'when additional classes are passed' do
        let(:options) { super().merge({ classes: 'my-custom-class' }) }

        it 'has the custom class' do
          expect(pagination_section[:class]).to eq('govuk-pagination my-custom-class')
        end
      end

      context 'when additional attributes are passed' do
        let(:options) { { attributes: { aria: { label: 'custom aria label' }, data: { test: 'hello there' }, id: 'custom-id' } } }

        it 'has the additional attributes' do
          expect(pagination_section[:'aria-label']).to eq('custom aria label')
          expect(pagination_section[:'data-test']).to eq('hello there')
          expect(pagination_section[:id]).to eq('custom-id')
        end
      end

      context 'when custom text is passed' do
        let(:options) do
          super().merge(
            {
              next: {
                href: '/next',
                text: 'Go to the next page'
              },
              previous: {
                href: '/previous',
                text: 'Go to the previous page'
              }
            }
          )
        end

        it 'has the custom text for next and previous' do
          expect(pagination_next_element).to have_content('Go to the next page')
          expect(pagination_prev_element).to have_content('Go to the previous page')
        end
      end

      context 'and label text is passed' do
        let(:options) do
          super().merge(
            {
              next: {
                href: '/next',
                lable_text: 'Go Beyond, Plus Ultra!'
              },
              previous: {
                href: '/previous',
                lable_text: 'Jet fire burn'
              }
            }
          )
        end

        it 'does not render the label text' do
          expect(pagination_prev_element).not_to have_content('Previous:Jet fire burn')
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end
      end

      context 'when there is only the previous link and no next' do
        let(:options) do
          super().merge(
            {
              next: nil
            }
          )
        end

        it 'does not render the next element' do
          expect(pagination_section).not_to have_css('div.govuk-pagination__next')
        end
      end

      context 'when there is only the next link and no previous' do
        let(:options) do
          super().merge(
            {
              previous: nil
            }
          )
        end

        it 'does not render the next element' do
          expect(pagination_section).not_to have_css('div.govuk-pagination__previous')
        end
      end

      context 'when there are no items' do
        let(:options) do
          super().merge(
            {
              items: nil
            }
          )
        end

        it 'correctly formats the HTML with pagination in a block' do
          expect(pagination_section.to_html).to eq('
            <nav class="govuk-pagination govuk-pagination--block" role="navigation" aria-label="results">
              <div class="govuk-pagination__prev">
                <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination--button_as_link" rel="prev">
                  <svg class="govuk-pagination__icon govuk-pagination__icon--prev" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                    <path d="m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z"></path>
                  </svg>
                  <span class="govuk-pagination__link-title govuk-pagination__link-title--decorated">
                    Previous
                  </span>
                </button>
              </div>
              <div class="govuk-pagination__next">
                <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination--button_as_link" rel="next">
                  <svg class="govuk-pagination__icon govuk-pagination__icon--next" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                    <path d="m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z"></path>
                  </svg>
                  <span class="govuk-pagination__link-title govuk-pagination__link-title--decorated">
                    Next
                  </span>
                </button>
              </div>
            </nav>
          '.to_one_line)
        end

        context 'and label text is passed' do
          let(:options) do
            super().merge(
              {
                next: {
                  href: '/next',
                  lable_text: 'Go Beyond, Plus Ultra!'
                },
                previous: {
                  href: '/previous',
                  lable_text: 'Jet fire burn'
                }
              }
            )
          end

          it 'renders the label text for the next and previous links' do
            expect(pagination_prev_element).to have_content('Previous:Jet fire burn')
            expect(pagination_next_element).to have_content('Next:Go Beyond, Plus Ultra!')
          end
        end
      end
    end
  end
end
