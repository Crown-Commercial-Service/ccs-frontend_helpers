# frozen_string_literal: true

require 'ccs/components/govuk/exit_this_page'

RSpec.describe CCS::Components::GovUK::ExitThisPage do
  include_context 'and I have a view context'

  let(:exit_this_page_element) { Capybara::Node::Simple.new(result).find('div.govuk-exit-this-page') }

  describe '.render' do
    let(:govuk_exit_this_page) { described_class.new(context: view_context, **options) }
    let(:result) { govuk_exit_this_page.render }

    let(:options) { {} }

    let(:default_html) do
      '
      <div class="govuk-exit-this-page" data-module="govuk-exit-this-page">
        <a rel="nofollow noreferrer" class="govuk-button govuk-button--warning govuk-exit-this-page__button govuk-js-exit-this-page-button" data-module="govuk-button" role="button" draggable="false" href="https://www.bbc.co.uk/weather">
          <span class="govuk-visually-hidden">Emergency</span> Exit this page
        </a>
      </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the button' do
        expect(exit_this_page_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_exit_this_page) { described_class.new(context: view_context) }

      it 'correctly formats the HTML with the button' do
        expect(exit_this_page_element.to_html).to eq(default_html)
      end
    end

    context 'when custom text is sent' do
      let(:govuk_exit_this_page) { described_class.new(text: 'Custom text', context: view_context) }

      it 'correctly formats the HTML with the button' do
        expect(exit_this_page_element.find('a')).to have_content('Custom text')
      end
    end

    context 'when custom redirect url is sent' do
      let(:govuk_exit_this_page) { described_class.new(redirect_url: '/custom/redirect/url', context: view_context) }

      it 'correctly formats the HTML with the button' do
        expect(exit_this_page_element.find('a')[:href]).to eq('/custom/redirect/url')
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-exit-this-page' } } }

      it 'has the id' do
        expect(exit_this_page_element[:id]).to eq('ouroboros-exit-this-page')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(exit_this_page_element[:class]).to eq('govuk-exit-this-page my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(exit_this_page_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when translated' do
      let(:options) do
        {
          activated_text: 'activatedText',
          timed_out_text: 'timedOutText',
          press_two_more_times_text: 'pressTwoMoreTimesText',
          press_one_more_time_text: 'pressOneMoreTimeText',
        }
      end

      # rubocop:disable RSpec/MultipleExpectations
      it 'has the additional attributes' do
        expect(exit_this_page_element[:'data-i18n.activated']).to eq('activatedText')
        expect(exit_this_page_element[:'data-i18n.timed-out']).to eq('timedOutText')
        expect(exit_this_page_element[:'data-i18n.press-two-more-times']).to eq('pressTwoMoreTimesText')
        expect(exit_this_page_element[:'data-i18n.press-one-more-time']).to eq('pressOneMoreTimeText')
      end
      # rubocop:enable RSpec/MultipleExpectations
    end
  end
end
