require_relative '../../../base'

module CCS
  module Components
    module GovUK
      class SummaryList < Base
        class Action
          # = GOV.UK Summary list action link
          #
          # @!attribute [r] text
          #   @return [String] Text for the action link
          # @!attribute [r] href
          #   @return [String] The href for the action link
          # @!attribute [r] visually_hidden_text
          #   @return [String] Visually hidden text for the action link
          # @!attribute [r] card_title
          #   @return [String] Card title text for the action link

          class Link < Base
            private

            attr_reader :text, :href, :visually_hidden_text, :card_title

            public

            # @param text [String] the text for the action link
            # @param href [String] the href for the action link
            # @param visually_hidden_text [String] optional visually hidden text for the action link
            # @param card_title [String] card title text for the action link
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the summary list action link HTML
            # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

            def initialize(text:, href:, visually_hidden_text: nil, card_title: nil, **options)
              super(**options)

              @text = text
              @href = href
              @visually_hidden_text = visually_hidden_text
              @card_title = card_title
            end

            # Generates the HTML for the GOV.UK Summary list action link
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              link_to(href, **@options[:attributes]) do
                concat(text)
                if visually_hidden_text.present? || card_title.present?
                  concat(tag.span(class: 'govuk-visually-hidden') do
                    if visually_hidden_text
                      concat(' ')
                      concat(visually_hidden_text)
                    end
                    if card_title
                      concat(' ')
                      concat("(#{card_title})")
                    end
                  end)
                end
              end
            end

            # The default attributes for the summary list action link

            DEFAULT_ATTRIBUTES = { class: 'govuk-link' }.freeze
          end
        end
      end
    end
  end
end
