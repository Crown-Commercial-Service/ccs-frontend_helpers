require_relative '../../base'
require_relative '../button'

module CCS
  module Components
    module GovUK
      class CookieBanner < Base
        # = GOV.UK Cookie Banner Action
        #
        # The individual cookie banner action.
        # It defaults to creating button unless a +href+ is set which will create a link
        #
        # @!attribute [r] text
        #   @return [String] Text for the action
        # @!attribute [r] href
        #   @return [String] The href for the action

        class Action < Base
          private

          attr_reader :text, :href

          public

          # @param text [String] the button or link text
          # @param href [String] the href for a link
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [String] : classes additional CSS classes for the cookie action button or link
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML.
          #                                    If the +:type+ key is present with a value of +:button+,
          #                                   the action will be rendered as a button

          def initialize(text:, href: nil, **options)
            super(**options)

            @text = text
            @href = href
          end

          # Generates the HTML for a cookie banner message action
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            if href && options[:attributes][:type] != :button
              link_to(text, href, **options[:attributes])
            else
              Button.new(text: text, href: href, context: context, **options).render
            end
          end

          # The default attributes for the cookie banner action

          DEFAULT_ATTRIBUTES = { class: 'govuk-link' }.freeze
        end
      end
    end
  end
end
