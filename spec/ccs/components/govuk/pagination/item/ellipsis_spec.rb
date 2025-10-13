# frozen_string_literal: true

require 'ccs/components/govuk/pagination/item/ellipsis'

RSpec.describe CCS::Components::GovUK::Pagination::Item::Ellipsis do
  let(:pagination_ellipsis_element) { Capybara::Node::Simple.new(result).find('li') }

  describe '.render' do
    let(:result) { described_class.render }

    it 'correctly formats the HTML for the pagination ellipsis' do
      expect(pagination_ellipsis_element.to_html).to eq('<li class="govuk-pagination__item govuk-pagination__item--ellipsis">⋯</li>')
    end
  end
end
