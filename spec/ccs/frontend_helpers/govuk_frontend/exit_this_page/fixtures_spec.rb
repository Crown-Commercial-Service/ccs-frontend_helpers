# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/exit_this_page'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::ExitThisPage, '#fixtures', type: :helper do
  include described_class

  describe '.govuk_exit_this_page from fixtures' do
    include_context 'and I have loaded the fixture'

    let(:component_name) { 'exit-this-page' }

    context "when the fixture is 'default'" do
      let(:fixture_name) { 'default' }
      let(:result) { govuk_exit_this_page(nil, fixture_options[:redirectUrl]) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'translated'" do
      let(:fixture_name) { 'translated' }
      let(:result) do
        govuk_exit_this_page(
          fixture_options[:text],
          activated_text: fixture_options[:activatedText],
          timed_out_text: fixture_options[:timedOutText],
          press_two_more_times_text: fixture_options[:pressTwoMoreTimesText],
          press_one_more_time_text: fixture_options[:pressOneMoreTimeText]
        )
      end

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'testing'" do
      let(:fixture_name) { 'testing' }
      let(:result) { govuk_exit_this_page(fixture_options[:text], fixture_options[:redirectUrl], classes: fixture_options[:classes], attributes: fixture_options[:attributes].merge({ id: fixture_options[:id] })) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end

    context "when the fixture is 'testing-html'" do
      let(:fixture_name) { 'testing-html' }
      let(:result) { govuk_exit_this_page(fixture_options[:html].html_safe) }

      it 'has HTML matching the fixture' do
        expect(result).to eq_html(fixture_html)
      end
    end
  end
end
