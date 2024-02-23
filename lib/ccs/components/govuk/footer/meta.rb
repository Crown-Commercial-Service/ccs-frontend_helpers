require_relative 'link'

module CCS
  module Components
    module GovUK
      class Footer < Base
        # = GOV.UK Footer Meta
        #
        # The footer meta section
        #
        # @!attribute [r] meta_links
        #   @return [Array<Link>] An array of the initialised meta links
        # @!attribute [r] visually_hidden_title
        #   @return [String] Title for the meta section
        # @!attribute [r] text
        #   @return [String] Text to add to the meta section of the footer

        class Meta
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :meta_links, :visually_hidden_title, :text

          public

          # @param items [Array<Hash>] an array of links for the meta section.
          #                            See {Components::GovUK::Footer::Link#initialize Link#initialize} for details of the items in the array.
          # @param visually_hidden_title [String] ('Support links') title for the meta section
          # @param text [String] text to add to the meta section of the footer
          # @param context [ActionView::Base] the view context

          def initialize(context:, items: nil, visually_hidden_title: nil, text: nil)
            @meta_links = items&.map { |meta_link| Link.new(li_class: 'govuk-footer__inline-list-item', context: context, **meta_link) }
            @visually_hidden_title = visually_hidden_title || 'Support links'
            @text = text
          end

          # Generates the HTML for the GOV.UK Footer Meta sections
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            capture do
              concat(tag.h2(visually_hidden_title, class: 'govuk-visually-hidden'))
              if meta_links.present?
                concat(tag.ul(class: 'govuk-footer__inline-list') do
                  meta_links.each { |meta_link| concat(meta_link.render) }
                end)
              end
              concat(tag.div(text, class: 'govuk-footer__meta-custom')) if text
            end
          end
        end
      end
    end
  end
end
