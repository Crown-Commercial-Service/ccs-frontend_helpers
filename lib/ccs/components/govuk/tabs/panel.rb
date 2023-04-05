require_relative '../../base'

module CCS
  module Components
    module GovUK
      class Tabs < Base
        # = GOV.UK Tabs panel
        #
        # The individual tab panels
        #
        # @!attribute [r] index
        #   @return [Integer] The index of the panel
        # @!attribute [r] id_prefix
        #   @return [String] Prefix id for the panel
        # @!attribute [r] content
        #   @return [ActiveSupport::SafeBuffer] HTML for the tab panel
        # @!attribute [r] text
        #   @return [String] Text for the tabs panel

        class Panel < Base
          private

          attr_reader :index, :id_prefix, :content, :text

          public

          # @param index [Integer] the index of the tab panel
          # @param id_prefix [Integer] prefix used for the id of a panel if no id is specified
          # @param content [ActiveSupport::SafeBuffer] HTML to use as content for the tab panel
          # @param text [String] if +:content+ is blank then this is the text used for the tab panel
          # @param options [Hash] options that will be used in customising the HTML
          #
          # @option options [Hash] :attributes any additional attributes that will added as part of the HTML

          def initialize(index:, id_prefix:, content: nil, text: nil, **options)
            super(**options)
            @options[:attributes][:class] = "govuk-tabs__panel #{'govuk-tabs__panel--hidden' if index > 1}".rstrip
            @options[:attributes][:id] ||= "#{id_prefix}-#{index}"

            @index = index
            @content = content
            @text = text
          end

          # Generates the HTML for the GOV.UK Tabs panel
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(**options[:attributes]) do
              content || tag.p(text, class: 'govuk-body')
            end
          end
        end
      end
    end
  end
end
