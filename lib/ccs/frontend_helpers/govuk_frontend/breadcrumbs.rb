# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Breadcrumbs
      #
      # This helper is used for generating the breadcrumbs component from the
      # {https://design-system.service.gov.uk/components/breadcrumbs GDS - Components - Breadcrumbs}

      module Breadcrumbs
        include SharedMethods
        include ActionView::Context
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper

        # Generates the HTML for the GOV.UK breadcrumbs component
        #
        # @param govuk_breadcrumb_items [Array<Hash>] An array of links for the breadcrumbs list. See {#govuk_breadcrumb_link} for details of the items in the array.
        # @param govuk_breadcrumbs_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_breadcrumbs_options [String] :classes additional CSS classes for the breadcrumbs HTML
        # @option govuk_breadcrumbs_options [Boolean] :collapse_on_mobile indicates if it is to colapse breadcrumbs on mobile
        # @option govuk_breadcrumbs_options [Hash] :attributes any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Breadcrumbs
        #                                     which can then be rendered on the page

        def govuk_breadcrumbs(govuk_breadcrumb_items, **govuk_breadcrumbs_options)
          initialise_attributes_and_set_classes(govuk_breadcrumbs_options, 'govuk-breadcrumbs')

          govuk_breadcrumbs_options[:attributes][:class] << ' govuk-breadcrumbs--collapse-on-mobile' if govuk_breadcrumbs_options[:collapse_on_mobile]

          tag.div(**govuk_breadcrumbs_options[:attributes]) do
            tag.ol(class: 'govuk-breadcrumbs__list') do
              govuk_breadcrumb_items.each { |govuk_breadcrumb_item| concat(govuk_breadcrumb_link(govuk_breadcrumb_item)) }
            end
          end
        end

        private

        # Generates the HTML for each link in the breadcrumbs.
        # It is called by {#govuk_breadcrumbs} which will pass in the breadcrum item.
        #
        # @param govuk_breadcrumb_item [Hash] a hash containg options for the breadcrumb item
        #
        # @option govuk_breadcrumb_item [String] :text the text for the link
        # @option govuk_breadcrumb_item [String] :href the URI for the link. If blank it is assumed that this item relates to current page
        # @option govuk_breadcrumb_item [Hash] :attributes any additional attributes that will added as part of the HTML.
        #                                                  If the link is blank then it defaults to +{ aria: { current: 'page' } }+
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Breadcrumb list item

        def govuk_breadcrumb_link(govuk_breadcrumb_item)
          if govuk_breadcrumb_item[:href].present?
            (govuk_breadcrumb_item[:attributes] ||= {})[:class] = 'govuk-breadcrumbs__link'

            tag.li(class: 'govuk-breadcrumbs__list-item') do
              link_to(govuk_breadcrumb_item[:text], govuk_breadcrumb_item[:href], **govuk_breadcrumb_item[:attributes])
            end
          else
            tag.li(class: 'govuk-breadcrumbs__list-item', aria: { current: 'page' }) do
              govuk_breadcrumb_item[:text]
            end
          end
        end
      end
    end
  end
end
