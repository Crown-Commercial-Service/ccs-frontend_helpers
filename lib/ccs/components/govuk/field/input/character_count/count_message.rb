module CCS
  module Components
    module GovUK
      class Field < Base
        class Input < Field
          class CharacterCount
            # = GOV.UK Character count message
            #
            # This is used to generate the character count message
            #
            # @!attribute [r] count_message
            #   @return [Hint] Hint with the count message
            # @!attribute [r] after_input
            #   @return [String] Text or HTML for after the textarea input

            class CountMessage
              include ActionView::Context
              include ActionView::Helpers

              private

              attr_reader :count_message, :after_input

              public

              # @param character_count_attribute [String] the name of the field as it will appear in the textarea
              # @param context [ActionView::Base] the view context
              # @param character_count_options (see CCS::Components::GovUK::Field::Input::CharacterCount.get_character_count_from_group_options)
              # @param after_input [String] Text or HTML that goes after the input
              #
              # @option (see CCS::Components::GovUK::Field::Input::CharacterCount.get_character_count_from_group_options)

              def initialize(character_count_attribute:, context:, character_count_options:, after_input: nil)
                count_message = character_count_options[:textarea_description] || {}

                count_message_length = character_count_options[:maxwords] || character_count_options[:maxlength]
                count_message_default = "You can enter up to %<count>s #{character_count_options[:maxwords] ? 'words' : 'characters'}"

                text = count_message_length ? format(count_message[:count_message] || count_message_default, count: count_message_length) : ''
                classes = "govuk-character-count__message #{count_message[:classes]}".rstrip

                @count_message = Hint.new(text: text, classes: classes, attributes: { id: "#{character_count_attribute}-info" }, context: context)
                @after_input = after_input
              end

              # Generates the HTML for the GOV.UK Character count message
              #
              # @return [ActiveSupport::SafeBuffer]

              def render
                capture do
                  concat(count_message.render)
                  concat(after_input) if after_input
                end
              end
            end
          end
        end
      end
    end
  end
end
