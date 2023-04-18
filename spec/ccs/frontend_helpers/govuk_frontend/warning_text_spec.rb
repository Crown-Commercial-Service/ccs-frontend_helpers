# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/warning_text'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::WarningText, type: :helper do
  include described_class

  let(:warning_text_element) { Capybara::Node::Simple.new(result).find('div.govuk-warning-text') }

  describe '.govuk_warning_text' do
    let(:result) { govuk_warning_text(text, **options) }

    let(:text) { 'You cannot go beyond here' }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-warning-text">
          <span class="govuk-warning-text__icon" aria-hidden="true">!</span>
          <strong class="govuk-warning-text__text">
            <span class="govuk-warning-text__assistive">Warning</span>
            You cannot go beyond here
          </strong>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the warning text' do
        expect(warning_text_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_warning_text(text) }

      it 'correctly formats the HTML with the warning text' do
        expect(warning_text_element.to_html).to eq(default_html)
      end
    end

    context 'when there is no text but there is a block' do
      let(:result) do
        govuk_warning_text do
          concat(tag.span('You cannot go beyond here.'))
          concat(tag.span('And we mean it this time!'))
        end
      end

      it 'correctly formats the HTML with the warning HTML' do
        expect(warning_text_element.to_html).to eq(
          '
            <div class="govuk-warning-text">
              <span class="govuk-warning-text__icon" aria-hidden="true">!</span>
              <strong class="govuk-warning-text__text">
                <span class="govuk-warning-text__assistive">Warning</span>
                <span>You cannot go beyond here.</span>
                <span>And we mean it this time!</span>
              </strong>
            </div>
          '.to_one_line
        )
      end
    end
  end
end
