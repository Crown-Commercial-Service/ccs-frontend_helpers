require 'ccs/components/govuk/skip_link'

RSpec.describe CCS::Components::GovUK::SkipLink do
  include_context 'and I have a view context'

  let(:skip_link_element) { Capybara::Node::Simple.new(result).find('a.govuk-skip-link') }

  describe '.render' do
    let(:govuk_skip_link) { described_class.new(text: text, href: href, context: view_context, **options) }
    let(:result) { govuk_skip_link.render }

    let(:text) { 'Skip' }
    let(:href) { '/skip' }
    let(:options) { {} }

    let(:default_html) { '<a class="govuk-skip-link" data-module="govuk-skip-link" href="/skip">Skip</a>' }

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML with the link' do
        expect(skip_link_element.to_html).to eq(default_html)
      end
    end

    context 'when no options are sent' do
      let(:govuk_skip_link) { described_class.new(text: text, href: href, context: view_context) }

      it 'correctly formats the HTML with the link' do
        expect(skip_link_element.to_html).to eq(default_html)
      end
    end

    context 'when no href is sent' do
      let(:govuk_skip_link) { described_class.new(text: text, context: view_context) }

      it 'correctly formats the HTML with the link to content' do
        expect(skip_link_element.to_html).to eq('<a class="govuk-skip-link" data-module="govuk-skip-link" href="#content">Skip</a>')
      end
    end

    context 'when an ID is passed as an attribute' do
      let(:options) { { attributes: { id: 'ouroboros-skip-link' } } }

      it 'has the id' do
        expect(skip_link_element[:id]).to eq('ouroboros-skip-link')
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(skip_link_element[:class]).to eq('govuk-skip-link my-custom-class')
      end
    end

    context 'when additional data attributes are passed' do
      let(:options) { { attributes: { data: { test: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(skip_link_element[:'data-module']).to eq('govuk-skip-link')
        expect(skip_link_element[:'data-test']).to eq('hello there')
      end
    end
  end
end
