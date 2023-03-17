require_relative '../base'
require_relative 'cookie_banner/message'

module CCS::Components
  module GovUK
    # = GOV.UK Cookie Banner
    #
    # This is used to generate the cookie banner component from the
    # {https://design-system.service.gov.uk/components/cookie-banner GDS - Components - Cookie banner}
    #
    # @!attribute [r] messages
    #   @return [Array<Message>] An array of the initialised cookie banner messages

    class CookieBanner < Base
      private

      attr_reader :messages

      public

      # @param messages [Array<Hash>] An array of messages for the cookie banner.
      #                               See {Components::GovUK::CookieBanner::Message#initialize Message#initialize} for details of the items in the array.
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the cookie banner HTML
      # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

      def initialize(messages:, **options)
        super(**options)

        (@options[:attributes][:data] ||= {})[:nosnippet] = 'true'
        @options[:attributes][:role] = 'region'
        (@options[:attributes][:aria] ||= {})[:label] ||= 'Cookie banner'

        @messages = messages.map { |message| Message.new(context: @context, **message) }
      end

      # Generates the HTML for the GOV.UK Cookie banner component
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          messages.each { |message| concat(message.render) }
        end
      end

      # The default attributes for the cookie banner

      DEFAULT_ATTRIBUTES = { class: 'govuk-cookie-banner' }.freeze
    end
  end
end
