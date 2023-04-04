# frozen_string_literal: true

require 'ccs/components/govuk/field/input/text_input/fix'

RSpec.describe CCS::Components::GovUK::Field::Input::TextInput::Fix do
  include_context 'and I have a view context'

  let(:fix_element) { Capybara::Node::Simple.new(result).find('div') }

  describe '.render' do
    let(:govuk_text_input_fix) { described_class.new(text: text, fix: fix, context: view_context, **options) }
    let(:result) { govuk_text_input_fix.render }

    let(:text) { '£' }
    let(:fix) { 'pre' }
    let(:options) { {} }

    let(:default_html) { '<div class="govuk-input__prefix" aria-hidden="true">£</div>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the fix' do
        expect(fix_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are not passed' do
      let(:govuk_text_input_fix) { described_class.new(text: text, fix: fix, context: view_context) }

      it 'correctly formats the HTML with the fix' do
        expect(fix_element.to_html).to eq(default_html)
      end
    end

    context 'and it has classes' do
      let(:options) { { classes: 'custom-prefix-class' } }

      it 'has the custom classes for the prefix' do
        expect(fix_element[:class]).to eq('govuk-input__prefix custom-prefix-class')
      end
    end

    context 'and it has custom attributes' do
      let(:options) { { attributes: { data: { test: 'hello there' }, aria: { describedby: 'some-id' } } } }

      it 'has the custom attributes for the prefix' do
        expect(fix_element[:'data-test']).to eq('hello there')
        expect(fix_element[:'aria-describedby']).to eq('some-id')
      end
    end
  end
end
