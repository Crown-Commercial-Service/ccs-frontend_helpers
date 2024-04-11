require_relative '../base'
require_relative 'form_group'
require_relative 'hint'

module CCS
  module Components
    module GovUK
      # = GOV.UK Field
      #
      # This class is used to create a form using the structure of a GDS input field components, e.g. text input.
      # It will wrap the input within the form group as well as find if there are any error messages to display.
      #
      # @!attribute [r] attribute
      #   @return [String,Symbol] The attribute of the field
      # @!attribute [r] error_message
      #   @return [String] The error message for the field
      # @!attribute [r] form_group
      #   @return [FormGroup] The initialised form group
      # @!attribute [r] hint
      #   @return [Hint] The initialised hint
      # @!attribute [r] before_input
      #   @return [String] Text or HTML to go before the input
      # @!attribute [r] after_input
      #   @return [String] Text or HTML to go after the input

      class Field < Base
        private

        attr_reader :attribute, :error_message, :form_group, :hint, :before_input, :after_input

        public

        # rubocop:disable Metrics/ParameterLists

        # @param attribute [String, Symbol] the attribute of the field
        # @param hint [Hash] attributes for the hint, see {CCS::Components::GovUK::Hint#initialize Hint#initialize} for more details.
        #                    If no hint is given then no hint will be rendered
        # @param form_group [Hash] attributes for the form group, see {CCS::Components::GovUK::FormGroup#initialize FormGroup#initialize} for more details.
        # @param options [Hash] options that will be used for the parts of the field
        #
        # @option options [String] :error_message (nil) the error message to be displayed
        # @option options [ActiveModel] :model (nil) optional model that can be used to find an error message
        # @option options [ActionView::Helpers::FormBuilder] :form (nil) optional form builder used to create
        #                                                                the field and find the error message
        # @option options [String] :classes additional CSS classes for the field HTML
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(attribute:, form_group: nil, hint: nil, before_input: nil, after_input: nil, **options)
          super(**options)

          (hint[:attributes] ||= {})[:id] = "#{attribute}-hint" if hint && !hint.dig(:attributes, :id)

          @attribute = attribute
          @error_message = find_error_message(attribute)

          @form_group = FormGroup.new(attribute: attribute, error_message: @error_message, context: @context, **(form_group || {}))
          @hint = Hint.new(context: @context, **hint) if hint
          @before_input = before_input
          @after_input = after_input
        end

        # rubocop:enable Metrics/ParameterLists

        # Generates the HTML to wrap arround a GDS form input component
        #
        # @yield the field HTML
        #
        # @yieldparam displayed_error_message [ActiveSupport::SafeBuffer] the error message HTML to display
        #
        # @return [ActiveSupport::SafeBuffer]

        def render(&block)
          form_group.render(&block)
        end

        private

        # If one is present it will find the error message text for the field
        #
        # @param attribute [String, Symbol] the attribute of the field
        #
        # @return [String]

        def find_error_message(attribute)
          if @options[:model]
            @options[:model].errors[attribute].first
          elsif options[:form]
            @options[:form].object.errors[attribute].first
          else
            @options[:error_message]
          end
        end

        # Adds the aira-describedby attribute for the field
        # if there is a hint or an error message
        #
        # @param field_options [Hash] the hash with the options to add the aria described by to
        # @param attribute [String, Symbol] the attribute of the field
        # @param error_message [String] used to indicate if there is an error
        # @param hint [Hash] the hint attributes

        def set_described_by(field_options, attribute, error_message, hint)
          aria_described_by = [
            field_options.dig(:attributes, :aria, :describedby),
            (hint[:attributes][:id] if hint),
            ("#{attribute}-error" if error_message)
          ].compact

          return unless aria_described_by.any?

          ((field_options[:attributes] ||= {})[:aria] ||= {})[:describedby] = aria_described_by.join(' ')
        end
      end
    end

    ActionView::Base.field_error_proc = proc { |html_tag, _instance| html_tag }
  end
end
