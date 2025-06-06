# frozen_string_literal: true

require 'ccs/components/govuk/logo'

RSpec.describe CCS::Components::GovUK::Logo do
  include_context 'and I have a view context'

  let(:logo_element) { Capybara::Node::Simple.new(result).find('svg') }
  let(:logo_title_element) { logo_element.find('title') }

  describe '.render' do
    let(:govuk_logo) { described_class.new(context: view_context, rebrand: rebrand, use_logotype: use_logotype, use_tudor_crown: use_tudor_crown, **options) }
    let(:result) { govuk_logo.render }

    let(:rebrand) { false }
    let(:use_logotype) { true }
    let(:use_tudor_crown) { true }
    let(:options) { {} }

    let(:default_html) do
      '
        <svg focusable="false" role="presentation" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 296 60" height="30" width="148" fill="currentcolor">
          <g>
            <circle cx="20" cy="17.6" r="3.7"></circle>
            <circle cx="10.2" cy="23.5" r="3.7"></circle>
            <circle cx="3.7" cy="33.2" r="3.7"></circle>
            <circle cx="31.7" cy="30.6" r="3.7"></circle>
            <circle cx="43.3" cy="17.6" r="3.7"></circle>
            <circle cx="53.2" cy="23.5" r="3.7"></circle>
            <circle cx="59.7" cy="33.2" r="3.7"></circle>
            <circle cx="31.7" cy="30.6" r="3.7"></circle>
            <path d="M33.1,9.8c.2-.1.3-.3.5-.5l4.6,2.4v-6.8l-4.6,1.5c-.1-.2-.3-.3-.5-.5l1.9-5.9h-6.7l1.9,5.9c-.2.1-.3.3-.5.5l-4.6-1.5v6.8l4.6-2.4c.1.2.3.3.5.5l-2.6,8c-.9,2.8,1.2,5.7,4.1,5.7h0c3,0,5.1-2.9,4.1-5.7l-2.6-8ZM37,37.9s-3.4,3.8-4.1,6.1c2.2,0,4.2-.5,6.4-2.8l-.7,8.5c-2-2.8-4.4-4.1-5.7-3.8.1,3.1.5,6.7,5.8,7.2,3.7.3,6.7-1.5,7-3.8.4-2.6-2-4.3-3.7-1.6-1.4-4.5,2.4-6.1,4.9-3.2-1.9-4.5-1.8-7.7,2.4-10.9,3,4,2.6,7.3-1.2,11.1,2.4-1.3,6.2,0,4,4.6-1.2-2.8-3.7-2.2-4.2.2-.3,1.7.7,3.7,3,4.2,1.9.3,4.7-.9,7-5.9-1.3,0-2.4.7-3.9,1.7l2.4-8c.6,2.3,1.4,3.7,2.2,4.5.6-1.6.5-2.8,0-5.3l5,1.8c-2.6,3.6-5.2,8.7-7.3,17.5-7.4-1.1-15.7-1.7-24.5-1.7h0c-8.8,0-17.1.6-24.5,1.7-2.1-8.9-4.7-13.9-7.3-17.5l5-1.8c-.5,2.5-.6,3.7,0,5.3.8-.8,1.6-2.3,2.2-4.5l2.4,8c-1.5-1-2.6-1.7-3.9-1.7,2.3,5,5.2,6.2,7,5.9,2.3-.4,3.3-2.4,3-4.2-.5-2.4-3-3.1-4.2-.2-2.2-4.6,1.6-6,4-4.6-3.7-3.7-4.2-7.1-1.2-11.1,4.2,3.2,4.3,6.4,2.4,10.9,2.5-2.8,6.3-1.3,4.9,3.2-1.8-2.7-4.1-1-3.7,1.6.3,2.3,3.3,4.1,7,3.8,5.4-.5,5.7-4.2,5.8-7.2-1.3-.2-3.7,1-5.7,3.8l-.7-8.5c2.2,2.3,4.2,2.7,6.4,2.8-.7-2.3-4.1-6.1-4.1-6.1h10.6,0Z"></path>
          </g>
          <path d="M88.6,33.2c0,1.8.2,3.4.6,5s1.2,3,2,4.4c1,1.2,2,2.2,3.4,3s3,1.2,5,1.2,3.4-.2,4.6-.8,2.2-1.4,3-2.2,1.2-1.8,1.6-3c.2-1,.4-2,.4-3v-.4h-10.6v-6.4h18.8v23h-7.4v-5c-.6.8-1.2,1.6-2,2.2-.8.6-1.6,1.2-2.6,1.8-1,.4-2,.8-3.2,1.2s-2.4.4-3.6.4c-3,0-5.8-.6-8-1.6-2.4-1.2-4.4-2.6-6-4.6s-2.8-4.2-3.6-6.8c-.6-2.8-1-5.6-1-8.6s.4-5.8,1.4-8.4,2.2-4.8,4-6.8,3.8-3.4,6.2-4.6c2.4-1.2,5.2-1.6,8.2-1.6s3.8.2,5.6.6c1.8.4,3.4,1.2,4.8,2s2.8,1.8,3.8,3c1.2,1.2,2,2.6,2.8,4l-7.4,4.2c-.4-.8-1-1.8-1.6-2.4-.6-.8-1.2-1.4-2-2s-1.6-1-2.6-1.4-2.2-.4-3.4-.4c-2,0-3.6.4-5,1.2-1.4.8-2.6,1.8-3.4,3-1,1.2-1.6,2.8-2,4.4-.6,1.6-.8,3.8-.8,5.4ZM161.4,24.6c-.8-2.6-2.2-4.8-4-6.8s-3.8-3.4-6.2-4.6c-2.4-1.2-5.2-1.6-8.4-1.6s-5.8.6-8.4,1.6c-2.2,1.2-4.4,2.8-6,4.6-1.8,2-3,4.2-4,6.8-.8,2.6-1.4,5.4-1.4,8.4s.4,5.8,1.4,8.4c.8,2.6,2.2,4.8,4,6.8s3.8,3.4,6.2,4.6c2.4,1.2,5.2,1.6,8.4,1.6s5.8-.6,8.4-1.6c2.4-1.2,4.6-2.6,6.2-4.6,1.8-2,3-4.2,4-6.8.8-2.6,1.4-5.4,1.4-8.4-.2-3-.6-5.8-1.6-8.4h0ZM154,33.2c0,2-.2,3.8-.8,5.4-.4,1.6-1.2,3.2-2.2,4.4s-2.2,2.2-3.4,2.8c-1.4.6-3,1-4.8,1s-3.4-.4-4.8-1-2.6-1.6-3.4-2.8c-1-1.2-1.6-2.6-2.2-4.4-.4-1.6-.8-3.4-.8-5.4v-.2c0-2,.2-3.8.8-5.4.4-1.6,1.2-3.2,2.2-4.4,1-1.2,2.2-2.2,3.4-2.8,1.4-.6,3-1,4.8-1s3.4.4,4.8,1,2.6,1.6,3.4,2.8c1,1.2,1.6,2.6,2.2,4.4.4,1.6.8,3.4.8,5.4v.2ZM177.8,54l-11.8-42h9.4l8,31.4h.2l8-31.4h9.4l-11.8,42h-11.4,0ZM235.4,46.7c1.2,0,2.4-.2,3.4-.6,1-.4,2-.8,2.8-1.6s1.4-1.6,1.8-2.8c.4-1.2.6-2.4.6-4V11.8h8.2v27.2c0,2.4-.4,4.4-1.2,6.2s-2,3.4-3.6,4.8c-1.4,1.4-3.2,2.4-5.4,3-2,.8-4.4,1-6.8,1s-4.8-.4-6.8-1c-2-.8-3.8-1.8-5.4-3-1.6-1.4-2.6-3-3.6-4.8-.8-1.8-1.2-4-1.2-6.2V11.7h8.4v26c0,1.6.2,2.8.6,4,.4,1.2,1,2,1.8,2.8s1.6,1.2,2.8,1.6c1.2.4,2.2.6,3.6.6h0ZM261.4,11.9h8.4v18.2l14.8-18.2h10.4l-14.4,16.8,15.4,25.2h-9.8l-11-18.8-5.4,6v12.8h-8.4V11.9h0ZM206.2,44.2c-3,0-5.4,2.4-5.4,5.4s2.4,5.4,5.4,5.4,5.4-2.4,5.4-5.4-2.4-5.4-5.4-5.4Z"></path>
        </svg>
      '.to_one_line
    end

    context 'when the default attributes are sent' do
      it 'correctly formats the HTML for the logo' do
        expect(logo_element.to_html).to eq(default_html)
      end
    end

    context 'when no attributes are sent' do
      let(:govuk_logo) { described_class.new(context: view_context) }

      it 'correctly formats the HTML for the logo' do
        expect(logo_element.to_html).to eq(default_html)
      end
    end

    context 'when additional classes are passed' do
      let(:options) { { classes: 'my-custom-class' } }

      it 'has the custom class' do
        expect(logo_element[:class]).to eq('my-custom-class')
      end
    end

    context 'when additional attributes are passed' do
      let(:options) { { attributes: { aria: { label: 'hello there' } } } }

      it 'has the additional attributes' do
        expect(logo_element[:'aria-label']).to eq('hello there')
        expect(logo_element[:role]).to eq('img')
        expect(logo_title_element).to have_content('hello there')
      end
    end

    context 'when rebrand is false' do
      context 'and use_logotype is false' do
        let(:use_logotype) { false }

        context 'and use_tudor_crown is false' do
          let(:use_tudor_crown) { false }

          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq('
              <svg focusable="false" role="presentation" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 72 60" height="30" width="36" fill="currentcolor">
                <path d="M13.4,22.3c2,.8,4.2-.2,5-2s-.2-4.2-2-5c-2-.8-4.2.2-5,2-.8,2,0,4.2,2,5M4.8,27.3c2,.8,4.2-.2,5-2s-.2-4.2-2-5c-2-.8-4.2.2-5,2-1,2,0,4.2,2,5M2.2,36.9c2,.8,4.2-.2,5-2,.8-2-.2-4.2-2-5-2-.8-4.2.2-5,2-.8,2,0,4.2,2,5M23,25.3c2,.8,4.2-.2,5-2s-.2-4.2-2-5c-2-.8-4.2.2-5,2s0,4.2,2,5M57.8,22.3c-2,.8-4.2-.2-5-2s.2-4.2,2-5c2-.8,4.2.2,5,2,1,2,0,4.2-2,5M66.4,27.3c-2,.8-4.2-.2-5-2s.2-4.2,2-5c2-.8,4.2.2,5,2,1,2,0,4.2-2,5M69,36.9c-2,.8-4.2-.2-5-2-.8-2,.2-4.2,2-5,2-.8,4.2.2,5,2,.8,2,0,4.2-2,5M48.2,25.3c-2,.8-4.2-.2-5-2s.2-4.2,2-5c2-.8,4.2.2,5,2s0,4.2-2,5M37.6,15.5l4.8,2.6v-7.2l-4.8,1.6c-.2-.2-.2-.4-.4-.4s2-6,2-6h-6.8l2,6c-.2.2-.4.2-.4.4-.2.2-4.8-1.4-4.8-1.4v7l4.8-2.6c-.2.2,0,.4.2.6l-2.8,8.4c-.2.4-.2.8-.2,1.4,0,2.2,1.6,4.2,3.8,4.4h1.2c2.2-.4,3.8-2.2,3.8-4.4s0-.8-.2-1.4l-2.8-8.4c.4-.2.6-.4.6-.6M35.6,56.1c9.2,0,17.8.6,25.6,1.8,2.2-9.2,4.8-14.4,7.6-18.2l-5.2-1.8c.6,2.6.6,3.8,0,5.6-.8-.8-1.6-2.4-2.2-4.8l-2.4,8.4c1.6-1,2.8-1.8,4-1.8-2.4,5.2-5.4,6.4-7.2,6-2.4-.4-3.4-2.6-3-4.4.6-2.6,3.2-3.2,4.4-.2,2.4-4.8-1.6-6.2-4.2-4.8,3.8-3.8,4.4-7.2,1.2-11.4-4.4,3.4-4.4,6.6-2.4,11.2-2.6-3-6.6-1.4-5,3.4,1.8-2.8,4.2-1,4,1.6-.4,2.4-3.4,4.2-7.4,4-5.6-.4-6-4.4-6-7.4,1.4-.2,3.8,1,6,4l.8-8.8c-2.2,2.4-4.4,2.8-6.6,2.8.8-2.4,4.2-6.2,4.2-6.2h-11s3.6,4,4.2,6.2c-2.2,0-4.4-.6-6.6-2.8l.8,8.8c2.2-3,4.6-4.2,6-4-.2,3.2-.4,7-6,7.4-3.8.4-7-1.6-7.4-4-.4-2.6,2-4.4,3.8-1.6,1.4-4.8-2.6-6.2-5.2-3.4,2-4.6,2-8-2.4-11.2-3.2,4.2-2.6,7.6,1.2,11.4-2.6-1.4-6.4,0-4.2,4.8,1.2-3,3.8-2.2,4.4.2.4,1.8-.8,3.8-3,4.4-2,.4-5-1-7.4-6,1.4,0,2.6.8,4,1.8l-3-8.4c-.6,2.4-1.4,3.8-2.4,4.8-.6-1.6-.4-3,0-5.6l-5.2,1.8c3,3.8,5.6,9,7.8,18.2,7.6-1,16.4-1.8,25.4-1.8"></path>
              </svg>
            '.to_one_line)
          end
        end

        context 'and use_tudor_crown is true' do
          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq('
              <svg focusable="false" role="presentation" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 64 60" height="30" width="32" fill="currentcolor">
                <g>
                  <circle cx="20" cy="17.6" r="3.7"></circle>
                  <circle cx="10.2" cy="23.5" r="3.7"></circle>
                  <circle cx="3.7" cy="33.2" r="3.7"></circle>
                  <circle cx="31.7" cy="30.6" r="3.7"></circle>
                  <circle cx="43.3" cy="17.6" r="3.7"></circle>
                  <circle cx="53.2" cy="23.5" r="3.7"></circle>
                  <circle cx="59.7" cy="33.2" r="3.7"></circle>
                  <circle cx="31.7" cy="30.6" r="3.7"></circle>
                  <path d="M33.1,9.8c.2-.1.3-.3.5-.5l4.6,2.4v-6.8l-4.6,1.5c-.1-.2-.3-.3-.5-.5l1.9-5.9h-6.7l1.9,5.9c-.2.1-.3.3-.5.5l-4.6-1.5v6.8l4.6-2.4c.1.2.3.3.5.5l-2.6,8c-.9,2.8,1.2,5.7,4.1,5.7h0c3,0,5.1-2.9,4.1-5.7l-2.6-8ZM37,37.9s-3.4,3.8-4.1,6.1c2.2,0,4.2-.5,6.4-2.8l-.7,8.5c-2-2.8-4.4-4.1-5.7-3.8.1,3.1.5,6.7,5.8,7.2,3.7.3,6.7-1.5,7-3.8.4-2.6-2-4.3-3.7-1.6-1.4-4.5,2.4-6.1,4.9-3.2-1.9-4.5-1.8-7.7,2.4-10.9,3,4,2.6,7.3-1.2,11.1,2.4-1.3,6.2,0,4,4.6-1.2-2.8-3.7-2.2-4.2.2-.3,1.7.7,3.7,3,4.2,1.9.3,4.7-.9,7-5.9-1.3,0-2.4.7-3.9,1.7l2.4-8c.6,2.3,1.4,3.7,2.2,4.5.6-1.6.5-2.8,0-5.3l5,1.8c-2.6,3.6-5.2,8.7-7.3,17.5-7.4-1.1-15.7-1.7-24.5-1.7h0c-8.8,0-17.1.6-24.5,1.7-2.1-8.9-4.7-13.9-7.3-17.5l5-1.8c-.5,2.5-.6,3.7,0,5.3.8-.8,1.6-2.3,2.2-4.5l2.4,8c-1.5-1-2.6-1.7-3.9-1.7,2.3,5,5.2,6.2,7,5.9,2.3-.4,3.3-2.4,3-4.2-.5-2.4-3-3.1-4.2-.2-2.2-4.6,1.6-6,4-4.6-3.7-3.7-4.2-7.1-1.2-11.1,4.2,3.2,4.3,6.4,2.4,10.9,2.5-2.8,6.3-1.3,4.9,3.2-1.8-2.7-4.1-1-3.7,1.6.3,2.3,3.3,4.1,7,3.8,5.4-.5,5.7-4.2,5.8-7.2-1.3-.2-3.7,1-5.7,3.8l-.7-8.5c2.2,2.3,4.2,2.7,6.4,2.8-.7-2.3-4.1-6.1-4.1-6.1h10.6,0Z"></path>
                </g>
              </svg>
            '.to_one_line)
          end
        end
      end

      context 'and use_logotype is true' do
        context 'and use_tudor_crown is false' do
          let(:use_tudor_crown) { false }

          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq('
              <svg focusable="false" role="presentation" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 304 60" height="30" width="152" fill="currentcolor">
                <path d="M13.4,22.3c2,.8,4.2-.2,5-2s-.2-4.2-2-5c-2-.8-4.2.2-5,2-.8,2,0,4.2,2,5M4.8,27.3c2,.8,4.2-.2,5-2s-.2-4.2-2-5c-2-.8-4.2.2-5,2-1,2,0,4.2,2,5M2.2,36.9c2,.8,4.2-.2,5-2,.8-2-.2-4.2-2-5-2-.8-4.2.2-5,2-.8,2,0,4.2,2,5M23,25.3c2,.8,4.2-.2,5-2s-.2-4.2-2-5c-2-.8-4.2.2-5,2s0,4.2,2,5M57.8,22.3c-2,.8-4.2-.2-5-2s.2-4.2,2-5c2-.8,4.2.2,5,2,1,2,0,4.2-2,5M66.4,27.3c-2,.8-4.2-.2-5-2s.2-4.2,2-5c2-.8,4.2.2,5,2,1,2,0,4.2-2,5M69,36.9c-2,.8-4.2-.2-5-2-.8-2,.2-4.2,2-5,2-.8,4.2.2,5,2,.8,2,0,4.2-2,5M48.2,25.3c-2,.8-4.2-.2-5-2s.2-4.2,2-5c2-.8,4.2.2,5,2s0,4.2-2,5M37.6,15.5l4.8,2.6v-7.2l-4.8,1.6c-.2-.2-.2-.4-.4-.4s2-6,2-6h-6.8l2,6c-.2.2-.4.2-.4.4-.2.2-4.8-1.4-4.8-1.4v7l4.8-2.6c-.2.2,0,.4.2.6l-2.8,8.4c-.2.4-.2.8-.2,1.4,0,2.2,1.6,4.2,3.8,4.4h1.2c2.2-.4,3.8-2.2,3.8-4.4s0-.8-.2-1.4l-2.8-8.4c.4-.2.6-.4.6-.6M35.6,56.1c9.2,0,17.8.6,25.6,1.8,2.2-9.2,4.8-14.4,7.6-18.2l-5.2-1.8c.6,2.6.6,3.8,0,5.6-.8-.8-1.6-2.4-2.2-4.8l-2.4,8.4c1.6-1,2.8-1.8,4-1.8-2.4,5.2-5.4,6.4-7.2,6-2.4-.4-3.4-2.6-3-4.4.6-2.6,3.2-3.2,4.4-.2,2.4-4.8-1.6-6.2-4.2-4.8,3.8-3.8,4.4-7.2,1.2-11.4-4.4,3.4-4.4,6.6-2.4,11.2-2.6-3-6.6-1.4-5,3.4,1.8-2.8,4.2-1,4,1.6-.4,2.4-3.4,4.2-7.4,4-5.6-.4-6-4.4-6-7.4,1.4-.2,3.8,1,6,4l.8-8.8c-2.2,2.4-4.4,2.8-6.6,2.8.8-2.4,4.2-6.2,4.2-6.2h-11s3.6,4,4.2,6.2c-2.2,0-4.4-.6-6.6-2.8l.8,8.8c2.2-3,4.6-4.2,6-4-.2,3.2-.4,7-6,7.4-3.8.4-7-1.6-7.4-4-.4-2.6,2-4.4,3.8-1.6,1.4-4.8-2.6-6.2-5.2-3.4,2-4.6,2-8-2.4-11.2-3.2,4.2-2.6,7.6,1.2,11.4-2.6-1.4-6.4,0-4.2,4.8,1.2-3,3.8-2.2,4.4.2.4,1.8-.8,3.8-3,4.4-2,.4-5-1-7.4-6,1.4,0,2.6.8,4,1.8l-3-8.4c-.6,2.4-1.4,3.8-2.4,4.8-.6-1.6-.4-3,0-5.6l-5.2,1.8c3,3.8,5.6,9,7.8,18.2,7.6-1,16.4-1.8,25.4-1.8"></path>
                <path d="M88.6,33.2c0,1.8.2,3.4.6,5s1.2,3,2,4.4c1,1.2,2,2.2,3.4,3s3,1.2,5,1.2,3.4-.2,4.6-.8,2.2-1.4,3-2.2,1.2-1.8,1.6-3c.2-1,.4-2,.4-3v-.4h-10.6v-6.4h18.8v23h-7.4v-5c-.6.8-1.2,1.6-2,2.2-.8.6-1.6,1.2-2.6,1.8-1,.4-2,.8-3.2,1.2s-2.4.4-3.6.4c-3,0-5.8-.6-8-1.6-2.4-1.2-4.4-2.6-6-4.6s-2.8-4.2-3.6-6.8c-.6-2.8-1-5.6-1-8.6s.4-5.8,1.4-8.4,2.2-4.8,4-6.8,3.8-3.4,6.2-4.6c2.4-1.2,5.2-1.6,8.2-1.6s3.8.2,5.6.6c1.8.4,3.4,1.2,4.8,2s2.8,1.8,3.8,3c1.2,1.2,2,2.6,2.8,4l-7.4,4.2c-.4-.8-1-1.8-1.6-2.4-.6-.8-1.2-1.4-2-2s-1.6-1-2.6-1.4-2.2-.4-3.4-.4c-2,0-3.6.4-5,1.2-1.4.8-2.6,1.8-3.4,3-1,1.2-1.6,2.8-2,4.4-.6,1.6-.8,3.8-.8,5.4ZM161.4,24.6c-.8-2.6-2.2-4.8-4-6.8s-3.8-3.4-6.2-4.6c-2.4-1.2-5.2-1.6-8.4-1.6s-5.8.6-8.4,1.6c-2.2,1.2-4.4,2.8-6,4.6-1.8,2-3,4.2-4,6.8-.8,2.6-1.4,5.4-1.4,8.4s.4,5.8,1.4,8.4c.8,2.6,2.2,4.8,4,6.8s3.8,3.4,6.2,4.6c2.4,1.2,5.2,1.6,8.4,1.6s5.8-.6,8.4-1.6c2.4-1.2,4.6-2.6,6.2-4.6,1.8-2,3-4.2,4-6.8.8-2.6,1.4-5.4,1.4-8.4-.2-3-.6-5.8-1.6-8.4h0ZM154,33.2c0,2-.2,3.8-.8,5.4-.4,1.6-1.2,3.2-2.2,4.4s-2.2,2.2-3.4,2.8c-1.4.6-3,1-4.8,1s-3.4-.4-4.8-1-2.6-1.6-3.4-2.8c-1-1.2-1.6-2.6-2.2-4.4-.4-1.6-.8-3.4-.8-5.4v-.2c0-2,.2-3.8.8-5.4.4-1.6,1.2-3.2,2.2-4.4,1-1.2,2.2-2.2,3.4-2.8,1.4-.6,3-1,4.8-1s3.4.4,4.8,1,2.6,1.6,3.4,2.8c1,1.2,1.6,2.6,2.2,4.4.4,1.6.8,3.4.8,5.4v.2ZM177.8,54l-11.8-42h9.4l8,31.4h.2l8-31.4h9.4l-11.8,42h-11.4,0ZM235.4,46.7c1.2,0,2.4-.2,3.4-.6,1-.4,2-.8,2.8-1.6s1.4-1.6,1.8-2.8c.4-1.2.6-2.4.6-4V11.8h8.2v27.2c0,2.4-.4,4.4-1.2,6.2s-2,3.4-3.6,4.8c-1.4,1.4-3.2,2.4-5.4,3-2,.8-4.4,1-6.8,1s-4.8-.4-6.8-1c-2-.8-3.8-1.8-5.4-3-1.6-1.4-2.6-3-3.6-4.8-.8-1.8-1.2-4-1.2-6.2V11.7h8.4v26c0,1.6.2,2.8.6,4,.4,1.2,1,2,1.8,2.8s1.6,1.2,2.8,1.6c1.2.4,2.2.6,3.6.6h0ZM261.4,11.9h8.4v18.2l14.8-18.2h10.4l-14.4,16.8,15.4,25.2h-9.8l-11-18.8-5.4,6v12.8h-8.4V11.9h0ZM206.2,44.2c-3,0-5.4,2.4-5.4,5.4s2.4,5.4,5.4,5.4,5.4-2.4,5.4-5.4-2.4-5.4-5.4-5.4Z" transform="translate(8 0)"></path>
              </svg>
            '.to_one_line)
          end
        end

        context 'and use_tudor_crown is true' do
          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq(default_html)
          end
        end
      end
    end

    context 'when rebrand is true' do
      let(:rebrand) { true }

      context 'and use_logotype is false' do
        let(:use_logotype) { false }

        let(:expected_html) do
          '
            <svg focusable="false" role="presentation" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 64 60" height="30" width="32" fill="currentcolor">
              <g>
                <circle cx="20" cy="17.6" r="3.7"></circle>
                <circle cx="10.2" cy="23.5" r="3.7"></circle>
                <circle cx="3.7" cy="33.2" r="3.7"></circle>
                <circle cx="31.7" cy="30.6" r="3.7"></circle>
                <circle cx="43.3" cy="17.6" r="3.7"></circle>
                <circle cx="53.2" cy="23.5" r="3.7"></circle>
                <circle cx="59.7" cy="33.2" r="3.7"></circle>
                <circle cx="31.7" cy="30.6" r="3.7"></circle>
                <path d="M33.1,9.8c.2-.1.3-.3.5-.5l4.6,2.4v-6.8l-4.6,1.5c-.1-.2-.3-.3-.5-.5l1.9-5.9h-6.7l1.9,5.9c-.2.1-.3.3-.5.5l-4.6-1.5v6.8l4.6-2.4c.1.2.3.3.5.5l-2.6,8c-.9,2.8,1.2,5.7,4.1,5.7h0c3,0,5.1-2.9,4.1-5.7l-2.6-8ZM37,37.9s-3.4,3.8-4.1,6.1c2.2,0,4.2-.5,6.4-2.8l-.7,8.5c-2-2.8-4.4-4.1-5.7-3.8.1,3.1.5,6.7,5.8,7.2,3.7.3,6.7-1.5,7-3.8.4-2.6-2-4.3-3.7-1.6-1.4-4.5,2.4-6.1,4.9-3.2-1.9-4.5-1.8-7.7,2.4-10.9,3,4,2.6,7.3-1.2,11.1,2.4-1.3,6.2,0,4,4.6-1.2-2.8-3.7-2.2-4.2.2-.3,1.7.7,3.7,3,4.2,1.9.3,4.7-.9,7-5.9-1.3,0-2.4.7-3.9,1.7l2.4-8c.6,2.3,1.4,3.7,2.2,4.5.6-1.6.5-2.8,0-5.3l5,1.8c-2.6,3.6-5.2,8.7-7.3,17.5-7.4-1.1-15.7-1.7-24.5-1.7h0c-8.8,0-17.1.6-24.5,1.7-2.1-8.9-4.7-13.9-7.3-17.5l5-1.8c-.5,2.5-.6,3.7,0,5.3.8-.8,1.6-2.3,2.2-4.5l2.4,8c-1.5-1-2.6-1.7-3.9-1.7,2.3,5,5.2,6.2,7,5.9,2.3-.4,3.3-2.4,3-4.2-.5-2.4-3-3.1-4.2-.2-2.2-4.6,1.6-6,4-4.6-3.7-3.7-4.2-7.1-1.2-11.1,4.2,3.2,4.3,6.4,2.4,10.9,2.5-2.8,6.3-1.3,4.9,3.2-1.8-2.7-4.1-1-3.7,1.6.3,2.3,3.3,4.1,7,3.8,5.4-.5,5.7-4.2,5.8-7.2-1.3-.2-3.7,1-5.7,3.8l-.7-8.5c2.2,2.3,4.2,2.7,6.4,2.8-.7-2.3-4.1-6.1-4.1-6.1h10.6,0Z"></path>
              </g>
            </svg>
          '.to_one_line
        end

        context 'and use_tudor_crown is false' do
          let(:use_tudor_crown) { false }

          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq(expected_html)
          end
        end

        context 'and use_tudor_crown is true' do
          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq(expected_html)
          end
        end
      end

      context 'and use_logotype is true' do
        let(:expected_html) do
          '
            <svg focusable="false" role="presentation" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 324 60" height="30" width="162" fill="currentcolor">
              <g>
                <circle cx="20" cy="17.6" r="3.7"></circle>
                <circle cx="10.2" cy="23.5" r="3.7"></circle>
                <circle cx="3.7" cy="33.2" r="3.7"></circle>
                <circle cx="31.7" cy="30.6" r="3.7"></circle>
                <circle cx="43.3" cy="17.6" r="3.7"></circle>
                <circle cx="53.2" cy="23.5" r="3.7"></circle>
                <circle cx="59.7" cy="33.2" r="3.7"></circle>
                <circle cx="31.7" cy="30.6" r="3.7"></circle>
                <path d="M33.1,9.8c.2-.1.3-.3.5-.5l4.6,2.4v-6.8l-4.6,1.5c-.1-.2-.3-.3-.5-.5l1.9-5.9h-6.7l1.9,5.9c-.2.1-.3.3-.5.5l-4.6-1.5v6.8l4.6-2.4c.1.2.3.3.5.5l-2.6,8c-.9,2.8,1.2,5.7,4.1,5.7h0c3,0,5.1-2.9,4.1-5.7l-2.6-8ZM37,37.9s-3.4,3.8-4.1,6.1c2.2,0,4.2-.5,6.4-2.8l-.7,8.5c-2-2.8-4.4-4.1-5.7-3.8.1,3.1.5,6.7,5.8,7.2,3.7.3,6.7-1.5,7-3.8.4-2.6-2-4.3-3.7-1.6-1.4-4.5,2.4-6.1,4.9-3.2-1.9-4.5-1.8-7.7,2.4-10.9,3,4,2.6,7.3-1.2,11.1,2.4-1.3,6.2,0,4,4.6-1.2-2.8-3.7-2.2-4.2.2-.3,1.7.7,3.7,3,4.2,1.9.3,4.7-.9,7-5.9-1.3,0-2.4.7-3.9,1.7l2.4-8c.6,2.3,1.4,3.7,2.2,4.5.6-1.6.5-2.8,0-5.3l5,1.8c-2.6,3.6-5.2,8.7-7.3,17.5-7.4-1.1-15.7-1.7-24.5-1.7h0c-8.8,0-17.1.6-24.5,1.7-2.1-8.9-4.7-13.9-7.3-17.5l5-1.8c-.5,2.5-.6,3.7,0,5.3.8-.8,1.6-2.3,2.2-4.5l2.4,8c-1.5-1-2.6-1.7-3.9-1.7,2.3,5,5.2,6.2,7,5.9,2.3-.4,3.3-2.4,3-4.2-.5-2.4-3-3.1-4.2-.2-2.2-4.6,1.6-6,4-4.6-3.7-3.7-4.2-7.1-1.2-11.1,4.2,3.2,4.3,6.4,2.4,10.9,2.5-2.8,6.3-1.3,4.9,3.2-1.8-2.7-4.1-1-3.7,1.6.3,2.3,3.3,4.1,7,3.8,5.4-.5,5.7-4.2,5.8-7.2-1.3-.2-3.7,1-5.7,3.8l-.7-8.5c2.2,2.3,4.2,2.7,6.4,2.8-.7-2.3-4.1-6.1-4.1-6.1h10.6,0Z"></path>
              </g>
              <circle class="govuk-logo-dot" cx="227" cy="36" r="7.3"></circle>
              <path d="M94.7,36.1c0,1.9.2,3.6.7,5.4.5,1.7,1.2,3.2,2.1,4.5.9,1.3,2.2,2.4,3.6,3.2,1.5.8,3.2,1.2,5.3,1.2s3.6-.3,4.9-.9c1.3-.6,2.3-1.4,3.1-2.3.8-.9,1.3-2,1.6-3,.3-1.1.5-2.1.5-3v-.4h-11v-6.6h19.5v24h-7.7v-5.4c-.5.8-1.2,1.6-2,2.3-.8.7-1.7,1.3-2.7,1.8-1,.5-2.1.9-3.3,1.2-1.2.3-2.5.4-3.8.4-3.2,0-6-.6-8.4-1.7-2.5-1.1-4.5-2.7-6.2-4.7-1.7-2-3-4.4-3.8-7.1-.9-2.7-1.3-5.6-1.3-8.7s.5-6,1.5-8.7,2.4-5.1,4.2-7.1c1.8-2,4-3.6,6.5-4.7s5.4-1.7,8.6-1.7,4,.2,5.9.7c1.8.5,3.5,1.1,5.1,2,1.5.9,2.9,1.9,4,3.2,1.2,1.2,2.1,2.6,2.8,4.1l-7.7,4.3c-.5-.9-1-1.8-1.6-2.6-.6-.8-1.3-1.5-2.2-2.1-.8-.6-1.7-1-2.8-1.4-1-.3-2.2-.5-3.5-.5-2,0-3.8.4-5.3,1.2s-2.7,1.9-3.6,3.2c-.9,1.3-1.7,2.8-2.1,4.6s-.7,3.5-.7,5.3v.3h0ZM152.9,13.7c3.2,0,6.1.6,8.7,1.7,2.6,1.2,4.7,2.7,6.5,4.7,1.8,2,3.1,4.4,4.1,7.1s1.4,5.6,1.4,8.7-.5,6-1.4,8.7c-.9,2.7-2.3,5.1-4.1,7.1s-4,3.6-6.5,4.7c-2.6,1.1-5.5,1.7-8.7,1.7s-6.1-.6-8.7-1.7c-2.6-1.1-4.7-2.7-6.5-4.7-1.8-2-3.1-4.4-4.1-7.1-.9-2.7-1.4-5.6-1.4-8.7s.5-6,1.4-8.7,2.3-5.1,4.1-7.1c1.8-2,4-3.6,6.5-4.7s5.4-1.7,8.7-1.7h0ZM152.9,50.4c1.9,0,3.6-.4,5-1.1,1.4-.7,2.7-1.7,3.6-3,1-1.3,1.7-2.8,2.2-4.5.5-1.7.8-3.6.8-5.7v-.2c0-2-.3-3.9-.8-5.7-.5-1.7-1.3-3.3-2.2-4.5-1-1.3-2.2-2.3-3.6-3-1.4-.7-3.1-1.1-5-1.1s-3.6.4-5,1.1c-1.5.7-2.7,1.7-3.6,3s-1.7,2.8-2.2,4.5c-.5,1.7-.8,3.6-.8,5.7v.2c0,2.1.3,4,.8,5.7.5,1.7,1.2,3.2,2.2,4.5,1,1.3,2.2,2.3,3.6,3,1.5.7,3.1,1.1,5,1.1ZM189.1,58l-12.3-44h9.8l8.4,32.9h.3l8.2-32.9h9.7l-12.3,44M262.9,50.4c1.3,0,2.5-.2,3.6-.6,1.1-.4,2-.9,2.8-1.7.8-.8,1.4-1.7,1.9-2.9.5-1.2.7-2.5.7-4.1V14h8.6v28.5c0,2.4-.4,4.6-1.3,6.6-.9,2-2.1,3.6-3.7,5-1.6,1.4-3.4,2.4-5.6,3.2-2.2.7-4.5,1.1-7.1,1.1s-4.9-.4-7.1-1.1c-2.2-.7-4-1.8-5.6-3.2s-2.8-3-3.7-5c-.9-2-1.3-4.1-1.3-6.6V14h8.7v27.2c0,1.6.2,2.9.7,4.1.5,1.2,1.1,2.1,1.9,2.9.8.8,1.7,1.3,2.8,1.7s2.3.6,3.6.6h0ZM288.5,14h8.7v19.1l15.5-19.1h10.8l-15.1,17.6,16.1,26.4h-10.2l-11.5-19.7-5.6,6.3v13.5h-8.7"></path>
            </svg>
          '.to_one_line
        end

        context 'and use_tudor_crown is false' do
          let(:use_tudor_crown) { false }

          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq(expected_html)
          end
        end

        context 'and use_tudor_crown is true' do
          it 'correctly formats the HTML for the logo' do
            expect(logo_element.to_html).to eq(expected_html)
          end
        end
      end
    end
  end
end
