# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/tag'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Tag, type: :helper do
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

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-tag' } } }

      it 'has the id' do
        expect(tag_element[:id]).to eq('ouroboros-tag')
      end
    end

    context 'when the colour option is passed' do
      let(:colour) { 'purple' }

      it 'has the additional colour class' do
        expect(tag_element[:class]).to eq('govuk-tag govuk-tag--purple')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(tag_element[:class]).to eq('govuk-tag my-custom-class')
      end
    end

    context 'when the colour option and additional classes are passed' do
      let(:colour) { 'purple' }
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the additional colour class' do
        expect(tag_element[:class]).to eq('govuk-tag govuk-tag--purple my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(tag_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
