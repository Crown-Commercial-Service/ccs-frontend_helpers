# frozen_string_literal: true

require_relative 'button'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Cookie Banner
      #
      # This helper is used for generating the cookie banner component from the
      # {https://design-system.service.gov.uk/components/cookie-banner GDS - Components - Cookie banner}

      module CookieBanner
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include Button

        # Generates the HTML for the GOV.UK Cookie banner component
        #
        # @param messages [Array] the different messages you can pass into the cookie banner. See {govuk_cookie_banner_message_content}
        # @param govuk_cookie_banner_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_cookie_banner_options [String] :classes additional CSS classes for the cookie banner HTML
        # @option govuk_cookie_banner_options [Hash] :attributes any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Cookie banner
        #                                     which can then be rendered on the page

        def govuk_cookie_banner(messages, **govuk_cookie_banner_options)
          determine_govuk_cookie_banner_attributes(govuk_cookie_banner_options)

          tag.div(**govuk_cookie_banner_options[:attributes]) do
            messages.each do |message|
              initialise_attributes_and_set_classes(message, 'govuk-cookie-banner__message govuk-width-container')

              concat(tag.div(**message[:attributes]) do
                concat(govuk_cookie_banner_message_content(message))
                concat(govuk_cookie_banner_message_actions(message[:actions])) if message[:actions]
              end)
            end
          end
        end

        private

        # Generates the HTML for a cookie banner message content used in {govuk_cookie_banner}
        #
        # @param message [Hash] the options for the cookie banner message
        #
        # @option message [String] :heading_text the heading text that displays in the message
        # @option message [ActiveSupport::SafeBuffer] :content HTML to use as content for the message
        # @option message [String] :text if +:content+ is blank then this is the text used for the message
        # @option message [Array] :actions the buttons and links that you want to display in the message. See {govuk_cookie_banner_message_actions}
        # @option message [String] :classes additional CSS classes for the cookie message HTML
        # @option message [Hash] :attributes any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for a cookie banner message content used in {govuk_cookie_banner}

        def govuk_cookie_banner_message_content(message)
          tag.div(class: 'govuk-grid-row') do
            tag.div(class: 'govuk-grid-column-two-thirds') do
              concat(tag.h2(message[:heading_text], class: 'govuk-cookie-banner__heading govuk-heading-m')) if message[:heading_text]
              concat(tag.div(class: 'govuk-cookie-banner__content') do
                message[:content] || tag.p(message[:text], class: 'govuk-body')
              end)
            end
          end
        end

        # rubocop:disable Metrics/AbcSize

        # Generates the HTML for the cookie banner message actions used in {govuk_cookie_banner}
        # It defaults to creating button unless a +href+ is set which will create a link
        #
        # @param message_actions [Hash] the options for the cookie banner message actions
        #
        # @option message_actions [String] :text the button or link text
        # @option message_actions [String] :href the href for a link
        # @option message_actions [String] :classes additional CSS classes for the cookie action button or link
        # @option message_actions [Hash] :attributes any additional attributes that will added as part of the HTML.
        #                                            If the +:type+ key is present with a value of +:button+,
        #                                            the action will be rendered as a button
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the cookie banner message actions used in {govuk_cookie_banner}

        def govuk_cookie_banner_message_actions(message_actions)
          tag.div(class: 'govuk-button-group') do
            message_actions.each do |message_action|
              message_action[:attributes] ||= {}

              concat(
                if message_action[:href]
                  if message_action[:attributes][:type] == :button
                    govuk_button(
                      message_action[:text],
                      href: message_action[:href],
                      classes: message_action[:classes],
                      attributes: message_action[:attributes]
                    )
                  else
                    message_action[:attributes][:class] = "govuk-link #{message_action[:classes]}".rstrip

                    link_to(message_action[:text], message_action[:href], **message_action[:attributes])
                  end
                else
                  govuk_button(
                    message_action[:text],
                    classes: message_action[:classes],
                    attributes: message_action[:attributes]
                  )
                end
              )
            end
          end
        end

        # rubocop:enable Metrics/AbcSize

        # Sets the default attributes for {govuk_cookie_banner}
        #
        # @param govuk_cookie_banner_options [Hash] options that will be used in customising the HTML
        #
        # @option (see govuk_cookie_banner)

        def determine_govuk_cookie_banner_attributes(govuk_cookie_banner_options)
          initialise_attributes_and_set_classes(govuk_cookie_banner_options, 'govuk-cookie-banner')

          (govuk_cookie_banner_options[:attributes][:data] ||= {})[:nosnippet] = 'true'
          govuk_cookie_banner_options[:attributes][:role] = 'region'
          (govuk_cookie_banner_options[:attributes][:aria] ||= {})[:label] ||= 'Cookie banner'
        end
      end
    end
  end
end
