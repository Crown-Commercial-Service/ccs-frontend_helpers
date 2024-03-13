require_relative '../../../base'

module CCS
  module Components
    module GovUK
      class TaskList < Base
        class Item < Base
          # = GOV.UK Task list item title
          #
          # @!attribute [r] text
          #   @return [String] Text for the title
          # @!attribute [r] href
          #   @return [String] Optional link for the title

          class Title < Base
            private

            attr_reader :text, :href

            public

            # @param text [String] the text for the title
            # @param id_prefix [String] the id prefix for the task list item
            # @param href [String] optional link for the title
            # @param hint_text [String] flag to indicate if there is a hint
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the task list item title HTML

            def initialize(text:, id_prefix:, href: nil, hint_text: nil, **options)
              super(**options)
              @options[:attributes][:aria] = { describedby: (hint_text ? "#{id_prefix}-hint " : '') + "#{id_prefix}-status" } if href

              @text = text
              @href = href
            end

            # Generates the HTML for the GOV.UK Task list item title
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              if href
                link_to(text, href, class: "govuk-link govuk-task-list__link #{@options[:attributes][:class]}".rstrip, aria: { describedby: @options[:attributes][:aria][:describedby] })
              else
                tag.div(text, class: @options[:attributes][:class])
              end
            end
          end
        end
      end
    end
  end
end
