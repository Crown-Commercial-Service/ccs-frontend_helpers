# frozen_string_literal: true

require 'ccs/components/ccs/logo'

RSpec.describe CCS::Components::CCS::Logo do
  include_context 'and I have a view context'
  include_context 'and I have created the CCS logo HTML'

  let(:logo_element) { Capybara::Node::Simple.new(result).find('span.ccs-logo') }

  describe '.render' do
    let(:result) { ccs_logo.render }

    context 'when the default attributes are sent' do
      let(:ccs_logo) { described_class.new(context: view_context) }

      it 'correctly formats the HTML for the logo' do
        expect(logo_element.to_html).to eq(ccs_logo_html)
      end
    end

    context 'when only showing the crown part of the logo' do
      let(:ccs_logo) { described_class.new(context: view_context, show_only_crown: true) }

      it 'correctly formats the HTML for the logo' do
        expect(logo_element.to_html).to eq(ccs_logo_crown_html)
      end
    end
  end
end
