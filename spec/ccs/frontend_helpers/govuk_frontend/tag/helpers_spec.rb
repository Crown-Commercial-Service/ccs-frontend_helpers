# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/tag'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tag, '#helpers', type: :helper do
  include described_class

  let(:tag_element) { Capybara::Node::Simple.new(result).find('strong.govuk-tag') }

  describe '.govuk_tag' do
    let(:result) { govuk_tag(tag_text, colour, **options) }

    let(:tag_text) { 'Chain attack max' }
    let(:colour) { nil }
    let(:options) { {} }

    let(:default_html) { '<strong class="govuk-tag">Chain attack max</strong>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the tag text' do
        expect(tag_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_tag(tag_text) }

      it 'correctly formats the HTML with the tag text' do
        expect(tag_element.to_html).to eq(default_html)
      end
    end
  end
end
