# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/phase_banner'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::PhaseBanner, type: :helper do
  include described_class

  let(:phase_banner_element) { Capybara::Node::Simple.new(result).find('div.govuk-phase-banner') }
  let(:phase_banner_tag_element) { phase_banner_element.find('strong') }

  describe '.govuk_phase_banner' do
    let(:result) { govuk_phase_banner(tag_options, text, **options) }

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
      let(:result) { govuk_phase_banner(tag_options, text) }

      it 'correctly formats the HTML with the tag and text' do
        expect(phase_banner_element.to_html).to eq(default_html)
      end
    end

    context 'when there is a block' do
      let(:result) do
        govuk_phase_banner(tag_options, **options) do
          tag.p('Hear that Noah? Lanz wants something a bit meatier')
        end
      end

      it 'renders the phase banner with the block' do
        expect(phase_banner_element.to_html).to eq('
          <div class="govuk-phase-banner">
            <p class="govuk-phase-banner__content">
              <strong class="govuk-tag govuk-phase-banner__content__tag">
                Eunie
              </strong>
              <span class="govuk-phase-banner__text">
                <p>
                  Hear that Noah? Lanz wants something a bit meatier
                </p>
              </span>
            </p>
          </div>
        '.to_one_line)
      end

      context 'and there is text too' do
        let(:result) do
          govuk_phase_banner(tag_options, text, **options) do
            tag.p('Hear that Noah? Lanz wants something a bit meatier')
          end
        end

        it 'renders only the text and not the block' do
          expect(phase_banner_element.to_html).to eq(default_html)
        end
      end
    end
  end
end
