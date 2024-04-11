require_relative 'textarea'
require_relative 'character_count/count_message'

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
            private

            attr_reader :textarea, :textarea_description

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

              initialise_textarea(attribute, character_count_attribute, character_count_options, context, options)
            end

            delegate :render, to: :textarea

            private

            # Initialises the Textarea for the character count
            #
            # @param attribute [Symbol] the attribute of the field
            # @param character_count_attribute [String] the name of the field as it will appear in the textarea
            # @param character_count_options [Hash] options for the character count
            # @param context [ActionView::Base] the view context
            # @param options [Hash] options that will be used for the textarea
            #
            # @option (see CCS::Components::GovUK::Field::Input::Textarea#initialize)

            def initialise_textarea(attribute, character_count_attribute, character_count_options, context, options)
              set_character_count_from_group_options(character_count_options, options)

              ((options[:attributes] ||= {})[:aria] ||= {})[:describedby] = [options.dig(:attributes, :aria, :describedby), "#{character_count_attribute}-info"].compact.join(' ')
              options[:classes] = "govuk-js-character-count #{options[:classes]}".rstrip

              count_message = CountMessage.new(character_count_attribute: character_count_attribute, context: context, character_count_options: character_count_options, after_input: options.delete(:after_input))
              @textarea = Textarea.new(attribute: attribute, context: context, after_input: count_message.render, **options)
            end

            # Returns the charcter count form group options
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

            def set_character_count_from_group_options(character_count_options, options)
              (options[:form_group] ||= {})[:classes] = "govuk-character-count #{options.dig(:form_group, :classes)}".rstrip
              ((options[:form_group][:attributes] ||= {})[:data] ||= {})[:module] = 'govuk-character-count'

              %i[maxlength threshold maxwords].each do |data_attribute|
                options[:form_group][:attributes][:data][data_attribute] = character_count_options[data_attribute].to_s if character_count_options[data_attribute]
              end

              get_chacrter_count_translations(character_count_options).each do |data_attribute, value|
                options[:form_group][:attributes][:data][data_attribute] = value
              end
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
