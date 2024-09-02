# frozen_string_literal: true

require 'ccs/components/govuk/service_navigation/link'

RSpec.describe CCS::Components::GovUK::ServiceNavigation::Link do
  include_context 'and I have a view context'

  let(:service_navigation_list_element) { Capybara::Node::Simple.new(result).find('li.govuk-service-navigation__item') }
  let(:service_navigation_link_element) { service_navigation_list_element.find('a.govuk-service-navigation__link') }
  let(:service_navigation_text_element) { service_navigation_list_element.find('span.govuk-service-navigation__text') }

  describe '.render' do
    let(:govuk_service_navigation_link) { described_class.new(text: text, href: href, context: view_context, **options) }
    let(:result) { govuk_service_navigation_link.render }

    let(:text) { 'Here we go' }
    let(:href) { '/here-we-go' }
    let(:options) { {} }

    let(:default_html) { '<li class="govuk-service-navigation__item"><a class="govuk-service-navigation__link" href="/here-we-go">Here we go</a></li>' }

    it 'correctly formats the HTML with the link inside the list element' do
      expect(service_navigation_list_element.to_html).to eq(default_html)
    end

    context 'when no options are sent' do
      let(:govuk_table_service_navigation_head_cell) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the link inside the list element' do
        expect(service_navigation_list_element.to_html).to eq(default_html)
      end
    end

    context 'when the item is active' do
      let(:options) { { active: true } }

      it 'has the active class' do
        expect(service_navigation_list_element[:class]).to eq('govuk-service-navigation__item govuk-service-navigation__item--active')
      end

      it 'has the text within a strong tag' do
        expect(service_navigation_list_element).to have_css('strong.govuk-service-navigation__active-fallback', text: 'Here we go')
      end

      it 'has the aria-current as "true"' do
        expect(service_navigation_link_element[:'aria-current']).to eq('true')
      end
    end

    context 'when the item is current' do
      let(:options) { { current: true } }

      it 'has the current class' do
        expect(service_navigation_list_element[:class]).to eq('govuk-service-navigation__item govuk-service-navigation__item--active')
      end

      it 'has the text within a strong tag' do
        expect(service_navigation_list_element).to have_css('strong.govuk-service-navigation__active-fallback', text: 'Here we go')
      end

      it 'has the aria-current as "page"' do
        expect(service_navigation_link_element[:'aria-current']).to eq('page')
      end
    end

    context 'when only the text is passed' do
      let(:govuk_service_navigation_link) { described_class.new(text: text, context: view_context, **options) }

      it 'has the text in the li without a link' do
        expect(service_navigation_list_element).to have_no_css('a', text: 'Here we go')
        expect(service_navigation_list_element).to have_content('Here we go')
      end

      context 'when the item is active' do
        let(:options) { { active: true } }

        it 'has the active class' do
          expect(service_navigation_list_element[:class]).to eq('govuk-service-navigation__item govuk-service-navigation__item--active')
        end

        it 'has the text within a strong tag' do
          expect(service_navigation_list_element).to have_css('strong.govuk-service-navigation__active-fallback', text: 'Here we go')
        end

        it 'has the aria-current as "true"' do
          expect(service_navigation_text_element[:'aria-current']).to eq('true')
        end
      end

      context 'when the item is current' do
        let(:options) { { current: true } }

        it 'has the current class' do
          expect(service_navigation_list_element[:class]).to eq('govuk-service-navigation__item govuk-service-navigation__item--active')
        end

        it 'has the text within a strong tag' do
          expect(service_navigation_list_element).to have_css('strong.govuk-service-navigation__active-fallback', text: 'Here we go')
        end

        it 'has the aria-current as "page"' do
          expect(service_navigation_text_element[:'aria-current']).to eq('page')
        end
      end
    end

    context 'when there is a custom class' do
      let(:options) { { attributes: { class: 'my-custom-navigation-item-class' } } }

      it 'does not have the custom class' do
        expect(service_navigation_link_element[:class]).to eq('govuk-service-navigation__link')
      end
    end

    context 'when there are additional attributes' do
      let(:options) { { attributes: { id: 'my-custom-navigation-item-id', data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(service_navigation_link_element[:id]).to eq('my-custom-navigation-item-id')
        expect(service_navigation_link_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
