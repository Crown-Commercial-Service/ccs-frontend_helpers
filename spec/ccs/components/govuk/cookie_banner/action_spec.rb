# frozen_string_literal: true

require 'ccs/components/govuk/cookie_banner/action'

RSpec.describe CCS::Components::GovUK::CookieBanner::Action do
  include_context 'and I have a view context'

  let(:cookie_banner_action_button) { Capybara::Node::Simple.new(result).find('.govuk-button') }
  let(:cookie_banner_action_link) { Capybara::Node::Simple.new(result).find('.govuk-link') }

  describe '.render' do
    let(:govuk_cookie_banner_action) { described_class.new(text: text, href: href, classes: classes, context: view_context, **options) }
    let(:result) { govuk_cookie_banner_action.render }

    let(:text) { 'Accept ouroboros cookies' }
    let(:href) { nil }
    let(:classes) { nil }
    let(:options) { {} }

    context 'and there is a href' do
      let(:href) { '/go-here' }

      context 'and the type is button' do
        let(:options) { { attributes: { type: :button } } }

        it 'renders a link with button classes' do
          expect(cookie_banner_action_button.to_html).to eq('<a type="button" class="govuk-button" data-module="govuk-button" role="button" draggable="false" href="/go-here">Accept ouroboros cookies</a>')
        end

        context 'when additional classes are passed' do
          let(:classes) { 'my-custom-action-class' }

          it 'has the custom class' do
            expect(cookie_banner_action_button[:class]).to eq('govuk-button my-custom-action-class')
          end
        end

        context 'when additional attributes are passed' do
          let(:options) { { attributes: { type: :button, id: 'my-custom-action-id', data: { test: 'hello there' } } } }

          it 'has the additional attributes' do
            expect(cookie_banner_action_button[:id]).to eq('my-custom-action-id')
            expect(cookie_banner_action_button[:'data-test']).to eq('hello there')
          end
        end
      end

      context 'and there is no type' do
        it 'renders a link' do
          expect(cookie_banner_action_link.to_html).to eq('<a class="govuk-link" href="/go-here">Accept ouroboros cookies</a>')
        end

        context 'when additional classes are passed' do
          let(:classes) { 'my-custom-action-class' }

          it 'has the custom class' do
            expect(cookie_banner_action_link[:class]).to eq('govuk-link my-custom-action-class')
          end
        end

        context 'when additional attributes are passed' do
          let(:options) { { attributes: { id: 'my-custom-action-id', data: { test: 'hello there' } } } }

          it 'has the additional attributes' do
            expect(cookie_banner_action_link[:id]).to eq('my-custom-action-id')
            expect(cookie_banner_action_link[:'data-test']).to eq('hello there')
          end
        end
      end
    end

    context 'and there is not a href' do
      context 'and the type is button' do
        let(:options) { { attributes: { type: :button } } }

        it 'renders a button' do
          expect(cookie_banner_action_button.to_html).to eq('<button name="button" type="button" class="govuk-button" data-module="govuk-button">Accept ouroboros cookies</button>')
        end

        context 'when additional classes are passed' do
          let(:classes) { 'my-custom-action-class' }

          it 'has the custom class' do
            expect(cookie_banner_action_button[:class]).to eq('govuk-button my-custom-action-class')
          end
        end

        context 'when additional attributes are passed' do
          let(:options) { { attributes: { type: :button, id: 'my-custom-action-id', data: { test: 'hello there' } } } }

          it 'has the additional attributes' do
            expect(cookie_banner_action_button[:id]).to eq('my-custom-action-id')
            expect(cookie_banner_action_button[:'data-test']).to eq('hello there')
          end
        end
      end

      context 'and there is no type' do
        it 'renders a submit button' do
          expect(cookie_banner_action_button.to_html).to eq('<button name="button" type="submit" class="govuk-button" data-module="govuk-button">Accept ouroboros cookies</button>')
        end

        context 'when additional classes are passed' do
          let(:classes) { 'my-custom-action-class' }

          it 'has the custom class' do
            expect(cookie_banner_action_button[:class]).to eq('govuk-button my-custom-action-class')
          end
        end

        context 'when additional attributes are passed' do
          let(:options) { { attributes: { id: 'my-custom-action-id', data: { test: 'hello there' } } } }

          it 'has the additional attributes' do
            expect(cookie_banner_action_button[:id]).to eq('my-custom-action-id')
            expect(cookie_banner_action_button[:'data-test']).to eq('hello there')
          end
        end
      end
    end
  end
end
