# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/error_summary'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ErrorSummary, '#helpers', type: :helper do
  include described_class

  let(:error_summary_element) { Capybara::Node::Simple.new(result).find('div.govuk-error-summary') }
  let(:error_summary_list_item) { error_summary_element.find('ul.govuk-error-summary__list > li') }

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

  describe '.govuk_error_summary' do
    let(:result) { govuk_error_summary(title, error_list, description, **options) }

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
      let(:result) { govuk_error_summary(title, error_list) }

      it 'correctly formats the HTML with the summary' do
        expect(error_summary_element.to_html).to eq(default_html)
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

  describe '.govuk_error_summary_with_model' do
    let(:result) { govuk_error_summary_with_model(test_model, title, description, **options) }
    let(:test_model) { TestModel.new }

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
                  <a href="#ouroboros-error">
                    You must select your favourite member
                  </a>
                </li>
                <li>
                  <a href="#xenoblade_chronicles_3-error">
                  You must select your favourite hero
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      '.to_one_line
    end

    before do
      test_model.errors.add(:ouroboros, message: 'You must select your favourite member')
      test_model.errors.add(:xenoblade_chronicles_3, message: 'You must select your favourite hero')
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the summary' do
        expect(error_summary_element.to_html).to eq(default_html)
      end
    end

    context 'when the no options are sent' do
      let(:result) { govuk_error_summary_with_model(test_model, title) }

      it 'correctly formats the HTML with the summary' do
        expect(error_summary_element.to_html).to eq(default_html)
      end
    end

    context 'when a description is passed' do
      let(:description) { 'Here are the issues' }

      it 'has the description' do
        expect(error_summary_element.to_html).to eq(
          '
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
                  <a href="#ouroboros-error">
                    You must select your favourite member
                  </a>
                </li>
                <li>
                  <a href="#xenoblade_chronicles_3-error">
                  You must select your favourite hero
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
      '.to_one_line
        )
      end
    end
  end
end
