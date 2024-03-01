# frozen_string_literal: true

require 'ccs/frontend_helpers/govuk_frontend/fieldset'

RSpec.describe CCS::FrontendHelpers::GovUKFrontend::Fieldset, '#helpers', type: :helper do
  include described_class

  let(:fieldset_group_element) { Capybara::Node::Simple.new(result).find('fieldset.govuk-fieldset') }

  describe '.govuk_fieldset' do
    let(:result) do
      govuk_fieldset(**options) do
        concat(tag.label('Agnus heros', for: 'agnus-heros'))
        concat(tag.input(id: 'agnus-heros'))
        concat(tag.label('Keves heros', for: 'keves-heros'))
        concat(tag.input(id: 'keves-heros'))
      end
    end

    let(:options) { { legend: { text: 'What heros are your favourite?' } } }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the legend and content' do
        expect(fieldset_group_element.to_html).to eq('
          <fieldset class="govuk-fieldset">
            <legend class="govuk-fieldset__legend">
              What heros are your favourite?
            </legend>
            <label for="agnus-heros">Agnus heros</label>
            <input id="agnus-heros">
            <label for="keves-heros">Keves heros</label>
            <input id="keves-heros">
          </fieldset>
        '.to_one_line)
      end
    end

    context 'when the no options are sent' do
      let(:result) do
        govuk_fieldset do
          concat(tag.label('Agnus heros', for: 'agnus-heros'))
          concat(tag.input(id: 'agnus-heros'))
          concat(tag.label('Keves heros', for: 'keves-heros'))
          concat(tag.input(id: 'keves-heros'))
        end
      end

      it 'correctly formats the HTML without a legend and but with the content' do
        expect(fieldset_group_element.to_html).to eq('
          <fieldset class="govuk-fieldset">
            <label for="agnus-heros">Agnus heros</label>
            <input id="agnus-heros">
            <label for="keves-heros">Keves heros</label>
            <input id="keves-heros">
          </fieldset>
        '.to_one_line)
      end
    end
  end
end
