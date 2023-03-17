# frozen_string_literal: true

require 'ccs/components/govuk/error_summary'

RSpec.describe CCS::Components::GovUK::ErrorSummary do
  include_context 'and I have a view context'

  let(:error_summary_element) { Capybara::Node::Simple.new(result).find('div.govuk-error-summary') }
  let(:error_summary_list_item) { error_summary_element.find('ul.govuk-error-summary__list > li') }

  describe '.render' do
    let(:govuk_error_summary) { described_class.new(title: title, error_summary_items: error_list, description: description, context: view_context, **options) }
    let(:result) { govuk_error_summary.render }

    let(:title) { 'There is a problem' }
    let(:error_list) do
      [
        {
          text: 'You must select your favourite character',
          href: '#favourite-character-error'
        },
        {
          text: 'You must select your least favourite character'
        }
      ]
    end
    let(:description) { nil }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-error-summary" data-module="govuk-error-summary">
          <div role="alert">
            <h2 class="govuk-error-summary__title">
              There is a problem
            </h2>
            <div class="govuk-error-summary__body">
              <ul class="govuk-list govuk-error-summary__list">
                <li>
                  <a href="#favourite-character-error">
                    You must select your favourite character
                  </a>
                </li>
                <li>
                  You must select your least favourite character
                </li>
              </ul>
            </div>
          </div>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary' do
        expect(error_summary_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:govuk_error_summary) { described_class.new(title: title, error_summary_items: error_list, context: view_context) }

      it 'correctly formats the HTML with the summary' do
        expect(error_summary_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed' do
      let(:options) { { attributes: { id: 'my-custom-id' } } }

      it 'has the id' do
        expect(error_summary_element[:id]).to eq('my-custom-id')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(error_summary_element[:class]).to eq('govuk-error-summary my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(error_summary_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when a description is passed' do
      let(:description) { 'Here are the issues' }

      it 'has the description' do
        expect(error_summary_element.to_html).to eq('
          <div class="govuk-error-summary" data-module="govuk-error-summary">
            <div role="alert">
              <h2 class="govuk-error-summary__title">
                There is a problem
              </h2>
              <div class="govuk-error-summary__body">
                <p>
                  Here are the issues
                </p>
                <ul class="govuk-list govuk-error-summary__list">
                  <li>
                    <a href="#favourite-character-error">
                      You must select your favourite character
                    </a>
                  </li>
                  <li>
                    You must select your least favourite character
                  </li>
                </ul>
              </div>
            </div>
          </div>
        '.to_one_line)
      end
    end
  end
end
