# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/pagination'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Pagination, '#helpers', type: :helper do
  include described_class

  let(:pagination_section) { Capybara::Node::Simple.new(result).find('nav.govuk-pagination') }

  let(:options) do
    {
      pagination_previous: {
        href: '/previous'
      },
      pagination_items: [
        {
          ellipsis: true
        },
        {
          href: '/?page=3',
          number: 3
        },
        {
          href: '/?page=4',
          number: 4,
          current: true
        },
        {
          href: '/?page=5',
          number: 5
        },
        {
          ellipsis: true
        }
      ],
      pagination_next: {
        href: '/next'
      }
    }
  end

  describe '.govuk_pagination' do
    let(:result) { govuk_pagination(**options) }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with pagination' do
        expect(pagination_section.to_html).to eq('
          <nav class="govuk-pagination" aria-label="Pagination">
            <div class="govuk-pagination__prev">
              <a class="govuk-link govuk-pagination__link" rel="prev" href="/previous">
                <svg class="govuk-pagination__icon govuk-pagination__icon--prev" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z"></path>
                </svg>
                <span class="govuk-pagination__link-title">
                  Previous<span class="govuk-visually-hidden"> page</span>
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
                  Next<span class="govuk-visually-hidden"> page</span>
                </span>
                <svg class="govuk-pagination__icon govuk-pagination__icon--next" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z"></path>
                </svg>
              </a>
            </div>
          </nav>
        '.to_one_line)
      end
    end
  end

  describe '.govuk_pagination with form' do
    include_context 'and I have a view context from self'
    include_context 'and I have a form'

    let(:result) { govuk_pagination(form: form, **options) }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with pagination' do
        expect(pagination_section.to_html).to eq('
          <nav class="govuk-pagination" aria-label="Pagination">
            <div class="govuk-pagination__prev">
              <button name="button" type="submit" class="govuk-link govuk-pagination__link pagination--button_as_link" rel="prev">
                <svg class="govuk-pagination__icon govuk-pagination__icon--prev" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m6.5938-0.0078125-6.7266 6.7266 6.7441 6.4062 1.377-1.449-4.1856-3.9768h12.896v-2h-12.984l4.2931-4.293-1.414-1.414z"></path>
                </svg>
                <span class="govuk-pagination__link-title">
                  Previous<span class="govuk-visually-hidden"> page</span>
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
                  Next<span class="govuk-visually-hidden"> page</span>
                </span>
                <svg class="govuk-pagination__icon govuk-pagination__icon--next" xmlns="http://www.w3.org/2000/svg" height="13" width="15" aria-hidden="true" focusable="false" viewbox="0 0 15 13">
                  <path d="m8.107-0.0078125-1.4136 1.414 4.2926 4.293h-12.986v2h12.896l-4.1855 3.9766 1.377 1.4492 6.7441-6.4062-6.7246-6.7266z"></path>
                </svg>
              </button>
            </div>
          </nav>
        '.to_one_line)
      end
    end
  end
end
