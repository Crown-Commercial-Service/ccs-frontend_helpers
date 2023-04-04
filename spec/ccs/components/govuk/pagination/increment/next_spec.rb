# frozen_string_literal: true

require 'ccs/components/govuk/pagination/increment/next'

RSpec.describe CCS::Components::GovUK::Pagination::Increment::Next do
  include_context 'and I have a view context'

  let(:pagination_next_element) { Capybara::Node::Simple.new(result).find('div.govuk-pagination__next') }
  let(:pagination_next_link_element) { pagination_next_element.find('a') }
  let(:pagination_next_button_element) { pagination_next_element.find('button') }
  let(:pagination_next_text) { pagination_next_element.find('span.govuk-pagination__link-title') }

  let(:result) { govuk_pagination_next.render }

  let(:block_is_level) { false }
  let(:options) { {} }

  describe '.render' do
    let(:govuk_pagination_next) { described_class.new(block_is_level: block_is_level, href: href, context: view_context, **options) }

    let(:href) { '/next' }

    let(:default_html) do
      '
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
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with pagination next link' do
        expect(pagination_next_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_pagination_next) { described_class.new(block_is_level: block_is_level, href: href, context: view_context) }

      it 'correctly formats the HTML with pagination next link' do
        expect(pagination_next_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'does not have the custom class on the link' do
        expect(pagination_next_link_element[:class]).to eq('govuk-link govuk-pagination__link')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { aria: { label: 'custom aria label' }, data: { test: 'hello there' }, id: 'custom-id' } } }

      it 'has the additional attributes on the link element' do
        expect(pagination_next_link_element[:'aria-label']).to eq('custom aria label')
        expect(pagination_next_link_element[:'data-test']).to eq('hello there')
        expect(pagination_next_link_element[:id]).to eq('custom-id')
      end
    end

    context 'when custom text is sent' do
      let(:options) { { text: 'Go to the next page' } }

      it 'has the custom text' do
        expect(pagination_next_element).to have_content('Go to the next page')
      end
    end

    context 'when block_is_level is false' do
      context 'and label text is not provided' do
        it 'does not have any label text' do
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does not have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title')
        end
      end

      context 'when label text is provided' do
        let(:options) { { label_text: 'Go Beyond, Plus Ultra!' } }

        it 'does not have the label text' do
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does not have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title')
        end
      end
    end

    context 'when block_is_level is true' do
      let(:block_is_level) { true }

      it 'renders the icon at the top' do
        expect(pagination_next_element.to_html).to eq('
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
        '.to_one_line)
      end

      context 'and label text is not provided' do
        it 'does not have the label text' do
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title govuk-pagination__link-title--decorated')
        end
      end

      context 'when label text is provided' do
        let(:options) { { label_text: 'Go Beyond, Plus Ultra!' } }

        it 'does have the label text' do
          expect(pagination_next_element).to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does not have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title')
        end
      end
    end
  end

  describe '.render with form' do
    include_context 'and I have a form'

    let(:govuk_pagination_next) { described_class.new(block_is_level: block_is_level, form: form, context: view_context, **options) }

    let(:default_html) do
      '
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
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with pagination next button' do
        expect(pagination_next_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_pagination_next) { described_class.new(block_is_level: block_is_level, form: form, context: view_context) }

      it 'correctly formats the HTML with pagination next button' do
        expect(pagination_next_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'does not have the custom class on the button' do
        expect(pagination_next_button_element[:class]).to eq('govuk-link govuk-pagination__link pagination--button_as_link')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { aria: { label: 'custom aria label' }, data: { test: 'hello there' }, id: 'custom-id' } } }

      it 'has the additional attributes on the button element' do
        expect(pagination_next_button_element[:'aria-label']).to eq('custom aria label')
        expect(pagination_next_button_element[:'data-test']).to eq('hello there')
        expect(pagination_next_button_element[:id]).to eq('custom-id')
      end
    end

    context 'when custom text is sent' do
      let(:options) { { text: 'Go to the next page' } }

      it 'has the custom text' do
        expect(pagination_next_element).to have_content('Go to the next page')
      end
    end

    context 'when block_is_level is false' do
      context 'and label text is not provided' do
        it 'does not have any label text' do
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does not have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title')
        end
      end

      context 'when label text is provided' do
        let(:options) { { label_text: 'Go Beyond, Plus Ultra!' } }

        it 'does not have the label text' do
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does not have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title')
        end
      end
    end

    context 'when block_is_level is true' do
      let(:block_is_level) { true }

      it 'renders the icon at the top' do
        expect(pagination_next_element.to_html).to eq('
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
        '.to_one_line)
      end

      context 'and label text is not provided' do
        it 'does not have the label text' do
          expect(pagination_next_element).not_to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title govuk-pagination__link-title--decorated')
        end
      end

      context 'when label text is provided' do
        let(:options) { { label_text: 'Go Beyond, Plus Ultra!' } }

        it 'does have the label text' do
          expect(pagination_next_element).to have_content('Next:Go Beyond, Plus Ultra!')
        end

        it 'does not have the title decorated class' do
          expect(pagination_next_text[:class]).to eq('govuk-pagination__link-title')
        end
      end
    end
  end
end
