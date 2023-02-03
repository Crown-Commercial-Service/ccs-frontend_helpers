# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/phase_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::PhaseBanner, type: :helper do
  include described_class

  let(:phase_banner_element) { Capybara::Node::Simple.new(result).find('div.govuk-phase-banner') }
  let(:phase_banner_tag_element) { phase_banner_element.find('strong') }

  describe '.govuk_phase_banner' do
    let(:result) { govuk_phase_banner(text, tag_options, **options) }

    let(:text) { 'Come on, who else?' }
    let(:tag_options) { { text: 'Eunie' } }
    let(:options) { {} }

    let(:default_html) do
      '
        <div class="govuk-phase-banner">
          <p class="govuk-phase-banner__content">
            <strong class="govuk-tag govuk-phase-banner__content__tag">
              Eunie
            </strong>
            <span class="govuk-phase-banner__text">
              Come on, who else?
            </span>
          </p>
        </div>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the tag and text' do
        expect(phase_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:result) { govuk_phase_banner(text, tag_options) }

      it 'correctly formats the HTML with the tag and text' do
        expect(phase_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-phase-banner' } } }

      it 'has the id' do
        expect(phase_banner_element[:id]).to eq('ouroboros-phase-banner')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(phase_banner_element[:class]).to eq('govuk-phase-banner my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(phase_banner_element[:'data-test']).to eq('hello there')
      end
    end

    context 'when additional options for the tag options are passed' do
      context 'and a colour is given' do
        let(:tag_options) { { text: 'Eunie', colour: 'green' } }

        it 'renders the tag in the phase banner with the correct colour' do
          expect(phase_banner_tag_element[:class]).to eq('govuk-tag govuk-tag--green govuk-phase-banner__content__tag')
        end
      end

      context 'and attributes are given' do
        let(:tag_options) { { text: 'Eunie', options: { classes: 'my-custom-tag-class', attributes: { id: 'my-custom-tag-id' } } } }

        it 'renders the tag in the phase banner with additional attributes' do
          expect(phase_banner_tag_element[:class]).to eq('govuk-tag govuk-phase-banner__content__tag my-custom-tag-class')
          expect(phase_banner_tag_element[:id]).to eq('my-custom-tag-id')
        end
      end

      context 'and both colour and attributes are given' do
        let(:tag_options) { { text: 'Eunie', colour: 'green', options: { classes: 'my-custom-tag-class', attributes: { id: 'my-custom-tag-id' } } } }

        it 'renders the tag in the phase banner with the correct colour additional attributes' do
          expect(phase_banner_tag_element[:class]).to eq('govuk-tag govuk-tag--green govuk-phase-banner__content__tag my-custom-tag-class')
          expect(phase_banner_tag_element[:id]).to eq('my-custom-tag-id')
        end
      end
    end
  end
end
