# frozen_string_literal: true

require_relative 'textarea'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      module Field
        # = GOV.UK Character count
        #
        # This helper is used for generating the character count component from the
        # {https://design-system.service.gov.uk/components/character-count GDS - Components - Character count}
        #
        # This is a wrapper around a Textarea module and so makes use of the methods in {Textarea}

        module CharacterCount
          include Textarea

          # Generates the HTML for the GOV.UK character count component.
          # It works by warpping the govuk_textarea in HTML which will trigger the JavaScript to do the character count.
          #
          # @param attribute [String, Symbol] the attribute of the character count text area
          # @param govuk_character_count_options [Hash] options that will be used for the parts of the form group, label, hint, textarea and the character count
          #
          # @option govuk_character_count_options [String] :error_message (nil) the error message to be displayed
          # @option govuk_character_count_options [ActiveModel] :model (nil) optional model that can be used to find an error message
          # @option govuk_character_count_options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
          #                                                                                 the textarea tag and find the error message
          # @option govuk_character_count_options [Hash] :form_group see {govuk_field}
          # @option govuk_character_count_options [Hash] :label see {govuk_field}
          # @option govuk_character_count_options [Hash] :hint see {govuk_field}
          # @option govuk_character_count_options [Hash] :textarea see {govuk_textarea}
          # @option govuk_character_count_options [Hash] :character_count ({}) the options that will be used when rendering the textarea.
          #                                                                    See {_govuk_character_count} for more details.
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK chracter count
          #                                     which can then be rendered on the page

          def govuk_character_count(attribute, **govuk_character_count_options)
            character_count_attribute = govuk_character_count_options[:form] ? "#{form.object_name}_#{attribute}" : attribute

            _govuk_character_count(character_count_attribute, **govuk_character_count_options) do |govuk_textarea_options|
              govuk_textarea(
                attribute,
                error_message: govuk_character_count_options[:error_message],
                model: govuk_character_count_options[:model],
                form: govuk_character_count_options[:form],
                **govuk_textarea_options
              )
            end
          end

          private

          # Wrapper method used by {govuk_character_count} to generate the character count HTML
          #
          # @param attribute [String, Symbol] the attribute of the character count
          # @param govuk_character_count_options [Hash] options that will be used in customising the HTML.
          #                                             This includes everything described in {govuk_character_count}
          #                                             with the addition of the +:character_count+ which are described below
          #
          # @option govuk_character_count_options [String] :maxlength (required) - if +maxwords+ is set, this is not required.
          #                                                           The maximum number of characters.
          #                                                           If +maxwords+ is provided, the +maxlength+ option will be ignored.
          # @option govuk_character_count_options [String] :maxwords (required) - if maxlength is set, this is not required.
          #                                                          The maximum number of words.
          #                                                          If +maxwords+ is provided, the +maxlength+ option will be ignored.
          # @option govuk_character_count_options [String] :threshold the percentage value of the limit at which point the count message is displayed.
          #                                                           If this attribute is set, the count message will be hidden by default.
          # @option govuk_textarea_options [Hash] :fallback_hint ({}) additional parameters that will be used to create the hint containing the character count text.
          #                                                                This includes all the options in {govuk_hint} plus +:count_message+.
          #                                                                This will replace the default text for the count message.
          #                                                                If you want the count number to appear, put %<count>s in the string and it will be replaced with the number
          #
          # @yield the textarea HTML generated by {govuk_character_count}
          #
          # @yieldparam govuk_textarea_options [Hash] the options used in the textarea called by {govuk_character_count}
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the chracter count which wrpas arround {govuk_character_count}

          def _govuk_character_count(attribute, **govuk_character_count_options)
            deep_init_hash(govuk_character_count_options, :textarea, :attributes, :aria)
            govuk_character_count_options[:textarea][:attributes][:aria][:describedby] = [govuk_character_count_options.dig(:textarea, :attributes, :aria, :describedby), "#{attribute}-info"].compact.join(' ')

            govuk_character_count_options[:textarea][:classes] = "#{govuk_character_count_options[:textarea][:classes]} govuk-js-character-count".lstrip

            tag.div(**get_character_count_attributes(**govuk_character_count_options)) do
              concat(yield(govuk_character_count_options))
              concat(character_count_hint(attribute, **govuk_character_count_options))
            end
          end

          # Generates the fallback hint HTML for {_govuk_character_count}
          #
          # @param (see _govuk_character_count)
          #
          # @option (see _govuk_character_count)
          #
          # @return [ActiveSupport::SafeBuffer] the HTML for the fullback hint used in {_govuk_character_count}

          def character_count_hint(attribute, **govuk_character_count_options)
            fallback_hint_length = govuk_character_count_options[:character_count][:maxwords] || govuk_character_count_options[:character_count][:maxlength]
            fallback_hint_default = "You can enter up to %<count>s #{govuk_character_count_options[:character_count][:maxwords] ? 'words' : 'characters'}"

            deep_init_hash(govuk_character_count_options, :character_count, :fallback_hint, :attributes)

            fallback_hint_text = format(govuk_character_count_options[:character_count][:fallback_hint][:count_message] || fallback_hint_default, count: fallback_hint_length)

            govuk_character_count_options[:character_count][:fallback_hint][:classes] = "#{govuk_character_count_options.dig(:character_count, :fallback_hint, :classes)} govuk-character-count__message".lstrip
            govuk_character_count_options[:character_count][:fallback_hint][:attributes].merge!(id: "#{attribute}-info")

            govuk_hint(fallback_hint_text, **govuk_character_count_options[:character_count][:fallback_hint])
          end

          # Generates a hash with the character count attributes used in {_govuk_character_count}
          #
          # @param govuk_character_count_options [Hash] options that will be used in customising the HTML.
          #                                             This includes everything described in {govuk_character_count}
          #                                             with the addition of the +:character_count+ which are described below
          #
          # @option (see _govuk_character_count)
          #
          # @return [Hash] contains the HTMl attributes used in {_govuk_character_count}

          def get_character_count_attributes(**govuk_character_count_options)
            govuk_character_count_attributes = { class: 'govuk-character-count', data: { module: 'govuk-character-count' } }

            %i[maxlength threshold maxwords].each do |data_attribute|
              govuk_character_count_attributes[:data][data_attribute] = govuk_character_count_options[:character_count][data_attribute].to_s if govuk_character_count_options[:character_count][data_attribute]
            end

            govuk_character_count_attributes
          end

          # Method to initialise hashes within hashes if it is not already initialised
          #
          # @param hash [Hash] the hash that is going to be initialised
          # @param keys [Array] the keys that are going to be initialised in the hash
          #
          # @example When the hash is completely empty
          #   hash = { }
          #   keys = [:a, :b, :c]
          #
          #   deep_init_hash(hash, *keys)
          #
          #   hash = { a: { b: { c: { } } } }
          #
          # @example When the hash has already been initialised
          #   hash = { a: { b: { d: 'hello' } } }
          #   keys = [:a, :b, :c]
          #
          #   deep_init_hash(hash, *keys)
          #
          #   hash = { a: { b: { d: 'hello', c: { } } } }

          def deep_init_hash(hash, *keys)
            current_hash = hash

            keys.each { |key| current_hash = (current_hash[key] ||= {}) }
          end
        end
      end
    end
  end
end
