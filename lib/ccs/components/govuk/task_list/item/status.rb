require_relative '../../../base'
require_relative '../../tag'

module CCS
  module Components
    module GovUK
      class TaskList < Base
        class Item < Base
          # = GOV.UK Task list item status
          #
          # @!attribute [r] text
          #   @return [String] Text for the status
          # @!attribute [r] tag_component
          #   @return [Tag] Tag for the status

          class Status < Base
            private

            attr_reader :tag_component, :text

            public

            # @param id_prefix [String] the id prefix for the task list item
            # @param tag_options [Hash] paramters for the govuk tag (see {Components::GovUK::Tag Tag}).
            #                   options are:
            #                   - +text+
            #                   - +colour+
            #                   - +options+
            # @param text [String] the text for the status. If tag is nil then this is used
            # @param options [Hash] options that will be used in customising the HTML
            #
            # @option options [String] :classes additional CSS classes for the task list row status HTML

            def initialize(id_prefix:, tag_options: nil, text: nil, **)
              super(**)
              @options[:attributes][:id] = "#{id_prefix}-status"

              @text = text
              @tag_component = Tag.new(context: @context, **tag_options) if tag_options
            end

            # Generates the HTML for the GOV.UK Task list item status
            #
            # @return [ActiveSupport::SafeBuffer]

            def render
              tag.div(class: @options[:attributes][:class], id: @options[:attributes][:id]) do
                if tag_component
                  tag_component.render
                else
                  text
                end
              end
            end

            # The default attributes for the task list item status

            DEFAULT_ATTRIBUTES = { class: 'govuk-task-list__status' }.freeze
          end
        end
      end
    end
  end
end
