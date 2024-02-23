require_relative '../../base'
require_relative 'action'

module CCS
  module Components
    module GovUK
      class CookieBanner < Base
        # = GOV.UK Cookie Banner Message
        #
        # The individual cookie banner message
        #
        # @!attribute [r] heading_text
        #   @return [String] Heading text for the message
        # @!attribute [r] content
        #   @return [ActiveSupport::SafeBuffer] HTML for the message
        # @!attribute [r] text
        #   @return [String] Text for the message
        # @!attribute [r] actions
        #   @return [Array<Action>] Array of initialised cookie banner actions

        class Message < Base
          private

          attr_reader :heading_text, :content, :text, :actions

          public

          # @param heading_text [String] the heading text that displays in the message
          # @param content [ActiveSupport::SafeBuffer] HTML to use as content for the message
          # @param text [String] if +:content+ is blank then this is the text used for the message
          # @param actions [Array<Hash>] the buttons and/or links that you want to display in the message.
          #                              See {Components::GovUK::CookieBanner::Action#initialize Action#initialize} for details of the items in the array.
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [String] :classes additional CSS classes for the cookie message HTML
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

          def initialize(heading_text: nil, content: nil, text: nil, actions: nil, **options)
            super(**options)

            @heading_text = heading_text
            @content = content
            @text = text
            @actions = actions.map { |action| Action.new(context: @context, **action) } if actions
          end

          # rubocop:disable Metrics/AbcSize

          # Generates the HTML for the GOV.UK Cookie Banner Message
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(**options[:attributes]) do
              concat(tag.div(class: 'govuk-grid-row') do
                tag.div(class: 'govuk-grid-column-two-thirds') do
                  concat(tag.h2(heading_text, class: 'govuk-cookie-banner__heading govuk-heading-m')) if heading_text
                  concat(tag.div(class: 'govuk-cookie-banner__content') do
                    content || tag.p(text, class: 'govuk-body') if content || text
                  end)
                end
              end)
              if actions
                concat(tag.div(class: 'govuk-button-group') do
                  actions.each { |action| concat(action.render) }
                end)
              end
            end
          end

          # rubocop:enable Metrics/AbcSize

          # The default attributes for the cookie banner message

          DEFAULT_ATTRIBUTES = { class: 'govuk-cookie-banner__message govuk-width-container' }.freeze
        end
      end
    end
  end
end
