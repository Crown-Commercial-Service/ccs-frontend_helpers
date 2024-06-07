require_relative 'link'

module CCS
  module Components
    module CCS
      class Footer < Base
        # = CCS Footer Meta
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
          #                            See {Components::CCS::Footer::Link#initialize Link#initialize} for details of the items in the array.
          # @param visually_hidden_title [String] ('Support links') title for the meta section
          # @param text [String] text to add to the meta section of the footer
          # @param context [ActionView::Base] the view context

          def initialize(context:, items: nil, visually_hidden_title: nil, text: nil)
            @meta_links = items.map { |meta_link| Link.new(li_class: 'ccs-footer__inline-list-item', context: context, **meta_link) } if items.present?
            @visually_hidden_title = visually_hidden_title || 'Support links'
            @text = text
          end

          # Generates the HTML for the CCS Footer Meta sections
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            capture do
              concat(tag.h2(visually_hidden_title, class: 'govuk-visually-hidden'))
              if meta_links
                concat(tag.ul(class: "ccs-footer__inline-list #{'ccs-footer__inline-list--bottom' unless text}".rstrip) do
                  meta_links.each { |meta_link| concat(meta_link.render) }
                end)
              end
              concat(tag.div(text, class: 'ccs-footer__meta-custom')) if text
            end
          end
        end
      end
    end
  end
end
