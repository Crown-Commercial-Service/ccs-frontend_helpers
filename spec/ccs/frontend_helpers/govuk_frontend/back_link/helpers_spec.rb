# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/back_link'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::BackLink, '#helpers', type: :helper do
  include described_class

  let(:back_link_element) { Capybara::Node::Simple.new(result).find('a.govuk-back-link') }

  describe '.govuk_back_link' do
    let(:result) { govuk_back_link(text, href, **options) }

    let(:text) { 'Back' }
    let(:href) { '/back' }
    let(:options) { {} }

    let(:default_html) { '<a class="govuk-back-link" href="/back">Back</a>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the link' do
        expect(back_link_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_back_link(text, href) }

      it 'correctly formats the HTML with the link' do
        expect(back_link_element.to_html).to eq(default_html)
      end
    end
  end
end
