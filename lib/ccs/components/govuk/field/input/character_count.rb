require_relative 'textarea'
require_relative '../../hint'

module CCS
  module Components
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
          # @!attribute [r] textarea_description
          #   @return [Hint] The initialised character count textarea description
          # @!attribute [r] character_count_html_options
          #   @return [Hash] HTML options for the character count

          class CharacterCount
            include ActionView::Context
            include ActionView::Helpers

            private

            attr_reader :textarea, :textarea_description, :character_count_html_options

            public

            # @param (see CCS::Components::GovUK::Field::Input::Textarea#initialize)
            # @param character_count_options [Hash] options for the character count
            # @param context [ActionView::Base] the view context
            #
            # @option (see CCS::Components::GovUK::Field::Input::Textarea#initialize)
            #
            # @option (see initialise_character_count_html_options)

            def initialize(attribute:, context:, character_count_options: {}, **options)
              character_count_attribute = options[:form] ? "#{options[:form].object_name}_#{attribute}" : attribute

              initialise_textarea(attribute, character_count_attribute, context, options)
              initialise_character_count_html_options(character_count_options)
              initialise_textarea_description(character_count_attribute, context, character_count_options)
            end

            # Generates the HTML for the GOV.UK Character count component
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.div(**character_count_html_options) do
                concat(textarea.render)
                concat(textarea_description.render)
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
              options[:classes] = "govuk-js-character-count #{options[:classes]}".rstrip

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
            # @option character_count_options [Hash] :textarea_description ({}) additional parameters that will be used to create the hint containing the character count text:
            #                                                            - +:count_message+ replaced the default text for the count message.
            #                                                                               If you want the count number to appear, put %<count>s in the string and it will be replaced with the number
            #                                                            - +classes+ additional CSS classes for the textarea description HTML
            # @option character_count_options [Hash] :characters_under_limit Message displayed when the number of characters is under the configured maximum, maxlength
            # @option character_count_options [String] :characters_at_limit_text Message displayed when the number of characters reaches the configured maximum, maxlength
            # @option character_count_options [Hash] :characters_over_limit Message displayed when the number of characters is over the configured maximum, maxlength
            # @option character_count_options [Hash] :words_under_limit Message displayed when the number of words is under the configured maximum, maxwords
            # @option character_count_options [String] :words_at_limit_text Message displayed when the number of words reaches the configured maximum, maxwords
            # @option character_count_options [Hash] :words_over_limit Message displayed when the number of words is over the configured maximum, maxwords

            def initialise_character_count_html_options(character_count_options)
              character_count_html_options = { class: 'govuk-character-count', data: { module: 'govuk-character-count' } }

              %i[maxlength threshold maxwords].each do |data_attribute|
                character_count_html_options[:data][data_attribute] = character_count_options[data_attribute].to_s if character_count_options[data_attribute]
              end

              get_chacrter_count_translations(character_count_options).each do |data_attribute, value|
                character_count_html_options[:data][data_attribute] = value
              end

              @character_count_html_options = character_count_html_options
            end

            # Initialises the charcter count textarea description
            #
            # @param character_count_attribute [String] the name of the field as it will appear in the textarea
            # @param context [ActionView::Base] the view context
            # @param (see initialise_character_count_html_options)
            #
            # @option (see initialise_character_count_html_options)

            def initialise_textarea_description(character_count_attribute, context, character_count_options)
              textarea_description = character_count_options[:textarea_description] || {}

              textarea_description_length = character_count_options[:maxwords] || character_count_options[:maxlength]
              textarea_description_default = "You can enter up to %<count>s #{character_count_options[:maxwords] ? 'words' : 'characters'}"

              text = textarea_description_length ? format(textarea_description[:count_message] || textarea_description_default, count: textarea_description_length) : ''
              classes = "govuk-character-count__message #{textarea_description[:classes]}".rstrip

              @textarea_description = Hint.new(text: text, classes: classes, attributes: { id: "#{character_count_attribute}-info" }, context: context)
            end

            # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

            # Returns the translation options for character count
            #
            # @param (see initialise_character_count_html_options)
            #
            # @option (see initialise_character_count_html_options)
            #
            # @return [Hash]

            def get_chacrter_count_translations(character_count_options)
              character_count_data_options = {}

              %i[characters_at_limit words_at_limit].each do |data_attribute|
                data_attribute_name = :"#{data_attribute}_text"
                character_count_data_options[:"i18n.#{data_attribute.to_s.gsub('_', '-')}"] = character_count_options[data_attribute_name] if character_count_options[data_attribute_name]
              end

              %i[characters_under_limit characters_over_limit words_under_limit words_over_limit].each do |data_attribute|
                next unless character_count_options[data_attribute]

                %i[other one].each do |plural_rule|
                  character_count_data_options[:"i18n.#{data_attribute.to_s.gsub('_', '-')}.#{plural_rule}"] = character_count_options[data_attribute][plural_rule] if character_count_options[data_attribute][plural_rule]
                end
              end

              character_count_data_options[:'i18n.textarea-description.other'] = character_count_options[:textarea_description][:count_message] if character_count_options.dig(:textarea_description, :count_message) && !(character_count_options[:maxwords] || character_count_options[:maxlength])

              character_count_data_options
            end

            # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
          end
        end
      end
    end
  end
end
