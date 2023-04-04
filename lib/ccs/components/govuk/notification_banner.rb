require_relative '../base'

module CCS::Components
  module GovUK
    # = GOV.UK Notification Banner
    #
    # This helper is used for generating the notification banner component from the
    # {https://design-system.service.gov.uk/components/notification-banner GDS - Components - Notification banner}
    #
    # @!attribute [r] text
    #   @return [String] Text for the notification banner
    # @!attribute [r] success_banner
    #   @return [Boolean] Indicates if this is a success banner

    class NotificationBanner < Base
      private

      attr_reader :text, :success_banner

      public

      # @param text [String] the text that will be used for the heading in the content section of the banner.
      #                      It is ignored if a block is given
      # @param success_banner [Boolean] will use the success banner options if this is set to true
      # @param options [Hash] options that will be used in customising the HTML
      #
      # @option options [String] :classes additional CSS classes for the notification banner HTML
      # @option options [String] :title_text ('Important') the title text shown at the top of the banner
      # @option options [String] :title_id ('govuk-notification-banner-title') the ID for the title text
      # @option options [String] :role ('region') the role for the banner
      # @option options [String] :heading_level (2) the heading level for the title text
      # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

      def initialize(text: nil, success_banner: nil, **options)
        super(**options)

        @text = text
        @success_banner = success_banner || false

        set_additional_options_for_banner
      end

      # Generates the HTML for the GOV.UK Notification banner component
      #
      # @yield HTML that will be contained within the 'govuk-notification-banner__content' div
      #
      # @return [ActiveSupport::SafeBuffer]

      def render
        tag.div(**options[:attributes]) do
          concat(tag.div(class: 'govuk-notification-banner__header') do
            tag.send(:"h#{options[:heading_level] || 2}", options[:title_text], class: 'govuk-notification-banner__title', id: options[:title_id])
          end)
          concat(tag.div(class: 'govuk-notification-banner__content') do
            if block_given?
              yield
            else
              tag.p(text, class: 'govuk-notification-banner__heading')
            end
          end)
        end
      end

      # The default attributes for the notifaction banner

      DEFAULT_ATTRIBUTES = { class: 'govuk-notification-banner', data: { module: 'govuk-notification-banner' } }.freeze

      # Default options used in normal versions of the notification banner

      DEFAULT_OPTIONS = {
        title_text: 'Important',
        title_id: 'govuk-notification-banner-title',
        role: 'region'
      }.freeze

      # Specific options for the success version of the notification banner

      SUCCESS_BANNER_OPTIONS = {
        classes: ' govuk-notification-banner--success',
        title_text: 'Success',
        role: 'alert'
      }.freeze

      private

      # rubocop:disable Metrics/AbcSize

      # Determines the banner options to be used for the notification banner

      def set_additional_options_for_banner
        banner_options = DEFAULT_OPTIONS.dup

        banner_options.merge!(SUCCESS_BANNER_OPTIONS) if success_banner

        options[:title_text] ||= banner_options[:title_text]
        options[:title_id] ||= banner_options[:title_id]
        options[:attributes][:role] ||= banner_options[:role]
        options[:attributes][:class] << banner_options[:classes].to_s
        (options[:attributes][:aria] ||= {})[:labelledby] = options[:title_id]
      end

      # rubocop:enable Metrics/AbcSize
    end
  end
end
