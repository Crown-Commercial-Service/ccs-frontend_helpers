# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Notification Banner
      #
      # This helper is used for generating the notification banner component from the
      # {https://design-system.service.gov.uk/components/notification-banner GDS - Components - Notification banner}

      module NotificationBanner
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper

        # Generates the HTML for the GOV.UK Notification banner component
        #
        # @param text [String] the text that will be used for the heading in the content section of the banner.
        #                      It is ignored if a block is given
        # @param success_banner [Boolean] will use the success banner options if this is set to true
        # @param govuk_notification_banner_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_notification_banner_options [String] :classes additional CSS classes for the notification banner HTML
        # @option govuk_notification_banner_options [String] :title_text ('Important') the title text shown at the top of the banner
        # @option govuk_notification_banner_options [String] :title_id ('govuk-notification-banner-title') the ID for the title text
        # @option govuk_notification_banner_options [String] :role ('region') the role for the banner
        # @option govuk_notification_banner_options [String] :heading_level (2) the heading level for the title text
        # @option govuk_notification_banner_options [Hash] :attributes ({data: { module: 'govuk-notification-banner' }, aria: { labelledby: 'govuk-notification-banner-title' }})
        #                                                  any additional attributes that will added as part of the HTML
        #
        # @yield HTML that will be contained within the 'govuk-notification-banner__content' div
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Notification banner
        #                                     which can then be rendered on the page

        def govuk_notification_banner(text = nil, success_banner = false, **govuk_notification_banner_options)
          banner_options = fetch_banner_options(success_banner, govuk_notification_banner_options)

          set_banner_classes(banner_options, govuk_notification_banner_options)
          set_banner_attributes(banner_options, govuk_notification_banner_options)

          tag.div(**govuk_notification_banner_options[:attributes]) do
            concat(tag.div(class: 'govuk-notification-banner__header') do
              tag.send(:"h#{govuk_notification_banner_options[:heading_level] || 2}", banner_options[:title_text], class: 'govuk-notification-banner__title', id: banner_options[:title_id])
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

        private

        # Determines the banner options to be used for {#govuk_notification_banner}
        #
        # @param success_banner [Boolean] will use the success banner options if this is set to true
        # @param govuk_notification_banner_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_notification_banner_options [String] :title_text ('Important') the title text shown at the top of the banner
        # @option govuk_notification_banner_options [String] :title_id ('govuk-notification-banner-title') the ID for the title text
        # @option govuk_notification_banner_options [String] :role ('region') the role for the banner
        #
        # @return [Hash] contains the following options used in {#govuk_notification_banner}:
        #                - +classes+
        #                - +title_text+
        #                - +title_id+
        #                - +role+

        def fetch_banner_options(success_banner, govuk_notification_banner_options)
          banner_options = DEFAULT_OPTIONS.dup

          banner_options.merge!(SUCCESS_BANNER_OPTIONS) if success_banner

          govuk_notification_banner_options.each do |key, value|
            banner_options[key] = value if banner_options.key?(key)
          end

          banner_options
        end

        # Sets the banner classes to be used for {#govuk_notification_banner}
        #
        # @param banner_options [Hash] this is the return value from {#fetch_banner_options}
        # @param govuk_notification_banner_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_notification_banner_options [String] :classes additional CSS classes for the notification banner HTML

        def set_banner_classes(banner_options, govuk_notification_banner_options)
          initialise_attributes_and_set_classes(govuk_notification_banner_options, 'govuk-notification-banner')

          govuk_notification_banner_options[:attributes][:class] << banner_options[:classes].to_s
        end

        # Sets the HTML attributes for {#govuk_notification_banner}
        #
        # @param banner_options [Hash] this is the return value from {#fetch_banner_options}
        # @param govuk_notification_banner_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_notification_banner_options [Hash] :attributes ({data: { module: 'govuk-notification-banner' }, aria: { labelledby: 'govuk-notification-banner-title' }})
        #                                                  any additional attributes that will added as part of the HTML

        def set_banner_attributes(banner_options, govuk_notification_banner_options)
          set_data_module(govuk_notification_banner_options, 'govuk-notification-banner')

          govuk_notification_banner_options[:attributes][:role] ||= banner_options[:role]
          (govuk_notification_banner_options[:attributes][:aria] ||= {})[:labelledby] = banner_options[:title_id]
        end

        # Default options used in normal versions of {#govuk_notification_banner}

        DEFAULT_OPTIONS = {
          title_text: 'Important',
          title_id: 'govuk-notification-banner-title',
          role: 'region'
        }.freeze

        # Options specific for the success version of {#govuk_notification_banner}

        SUCCESS_BANNER_OPTIONS = {
          classes: ' govuk-notification-banner--success',
          title_text: 'Success',
          role: 'alert'
        }.freeze
      end
    end
  end
end
