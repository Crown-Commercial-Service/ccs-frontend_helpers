require_relative 'textarea'
require_relative '../../hint'

module CCS::Components
  module GovUK
    class Field < Base
      class Input < Field
        # = GOV.UK Character count
        #
        # This is used for generating the character count component from the
        # {https://design-system.service.gov.uk/components/character-count GDS - Components - Character count}
        #
        # This is a wrapper around a Textarea module and so makes use of the methods in {Textarea}
        #
        # @!attribute [r] textarea
        #   @return [Textarea] The initialised textarea
        # @!attribute [r] fallback_hint
        #   @return [Hint] The initialised character count fallback hint
        # @!attribute [r] character_count_html_options
        #   @return [Hash] HTML options for the character count

        class CharacterCount
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :textarea, :fallback_hint, :character_count_html_options

          public

          # @param (see CCS::Components::GovUK::Field::Input::Textarea#initialize)
          # @param character_count_options [Hash] options for the character count
          # @param context [ActionView::Base] the view context
          #
          # @option (see CCS::Components::GovUK::Field::Input::Textarea#initialize)
          #
          # @option (see initialise_character_count_html_options)

          def initialize(attribute:, character_count_options:, context:, **options)
            character_count_attribute = options[:form] ? "#{options[:form].object_name}_#{attribute}" : attribute

            initialise_textarea(attribute, character_count_attribute, context, options)
            initialise_character_count_html_options(character_count_options)
            initialise_fallback_hint(character_count_attribute, context, character_count_options)
          end

          # Generates the HTML for the GOV.UK Character count component
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(**character_count_html_options) do
              concat(textarea.render)
              concat(fallback_hint.render)
            end
          end

          private

          # Initialises the Textarea for the character count
          #
          # @param attribute [Symbol] the attribute of the field
          # @param character_count_attribute [String] the name of the field as it will appear in the textarea
          # @param context [ActionView::Base] the view context
          # @param options [Hash] options that will be used for the textarea
          #
          # @option (see CCS::Components::GovUK::Field::Input::Textarea#initialize)

          def initialise_textarea(attribute, character_count_attribute, context, options)
            ((options[:attributes] ||= {})[:aria] ||= {})[:describedby] = [options.dig(:attributes, :aria, :describedby), "#{character_count_attribute}-info"].compact.join(' ')
            options[:classes] = "#{options[:classes]} govuk-js-character-count".lstrip

            @textarea = Textarea.new(attribute: attribute, context: context, **options)
          end

          # Initialises the charcter count options
          #
          # @param character_count_options [Hash] options for the charcter count
          #
          # @option character_count_options [String] :maxlength the maximum number of characters.
          #                                                     If +maxwords+ is set, this is not required.
          #                                                     If +maxwords+ is provided, the +maxlength+ option will be ignored.
          # @option character_count_options [String] :maxwords the maximum number of words.
          #                                                    If maxlength is set, this is not required.
          #                                                    If +maxwords+ is provided, the +maxlength+ option will be ignored.
          # @option character_count_options [String] :threshold the percentage value of the limit at which point the count message is displayed.
          #                                                     If this attribute is set, the count message will be hidden by default.
          # @option character_count_options [Hash] :fallback_hint ({}) additional parameters that will be used to create the hint containing the character count text:
          #                                                            - +:count_message+ replaced the default text for the count message.
          #                                                                               If you want the count number to appear, put %<count>s in the string and it will be replaced with the number
          #                                                            - +classes+ additional CSS classes for the fallback hint HTML

          def initialise_character_count_html_options(character_count_options)
            character_count_html_options = { class: 'govuk-character-count', data: { module: 'govuk-character-count' } }

            %i[maxlength threshold maxwords].each do |data_attribute|
              character_count_html_options[:data][data_attribute] = character_count_options[data_attribute].to_s if character_count_options[data_attribute]
            end

            @character_count_html_options = character_count_html_options
          end

          # Initialises the charcter count fall back hint
          #
          # @param character_count_attribute [String] the name of the field as it will appear in the textarea
          # @param context [ActionView::Base] the view context
          # @param (see initialise_character_count_html_options)
          #
          # @option (see initialise_character_count_html_options)

          def initialise_fallback_hint(character_count_attribute, context, character_count_options)
            fallback_hint = character_count_options[:fallback_hint] || {}

            fallback_hint_length = character_count_options[:maxwords] || character_count_options[:maxlength]
            fallback_hint_default = "You can enter up to %<count>s #{character_count_options[:maxwords] ? 'words' : 'characters'}"

            text = format(fallback_hint[:count_message] || fallback_hint_default, count: fallback_hint_length)
            classes = "#{fallback_hint[:classes]} govuk-character-count__message".lstrip

            @fallback_hint = Hint.new(text: text, classes: classes, attributes: { id: "#{character_count_attribute}-info" }, context: context)
          end
        end
      end
    end
  end
end
