require_relative '../base'
require_relative 'button'

module CCS
  module Components
    module GovUK
      # = GOV.UK Exit this page
      #
      # This is used to generate the exit this page component from the
      # {https://design-system.service.gov.uk/components/exit-this-page GDS - Components - Exit this page}
      #
      # @!attribute [r] text
      #   @return [String] Text for the exit this page
      # @!attribute [r] redirect_url
      #   @return [String] The redirect_url for the exit this page

      class ExitThisPage < Base
        include ActionView::Context
        include ActionView::Helpers

        private

        attr_reader :text, :redirect_url

        public

        # @param text [String] the text for the exit this page
        # @param redirect_url [String] the href for the exit this page
        # @param options [Hash] options that will be used in customising the HTML
        #
        # @option options [String] :classes additional CSS classes for the exit this page HTML
        # @option options [String] :activated_text Text announced by screen readers when Exit this Page has been activated via the keyboard shortcut. Defaults to "Loading."
        # @option options [String] :timed_out_text Text announced by screen readers when the keyboard shortcut has timed out without successful activation. Defaults to "Exit this page expired."
        # @option options [String] :press_two_more_times_text Text announced by screen readers when the user must press Shift two more times to activate the button. Defaults to "Shift, press 2 more times to exit."
        # @option options [String] :press_one_more_time_text Text announced by screen readers when the user must press Shift one more time to activate the button. Defaults to "Shift, press 1 more time to exit."
        # @option options [Hash] :attributes ({}) any additional attributes that will added as part of the HTML

        def initialize(text: nil, redirect_url: nil, **options)
          super(**options)

          @text = text || default_text
          @redirect_url = redirect_url || 'https://www.bbc.co.uk/weather'

          %i[activated timed_out press_two_more_times press_one_more_time].each do |data_attribute|
            data_attribute_name = :"#{data_attribute}_text"
            @options[:attributes][:data][:"i18n.#{data_attribute.to_s.gsub('_', '-')}"] = options[data_attribute_name] if options[data_attribute_name]
          end
        end

        # Generates the HTML for the GOV.UK Exit this page component
        #
        # @return [ActiveSupport::SafeBuffer]

        def render
          tag.div(**options[:attributes]) do
            Button.new(text: text, href: redirect_url, context: context, classes: 'govuk-button--warning govuk-exit-this-page__button govuk-js-exit-this-page-button', attributes: { rel: 'nofollow noreferrer' }).render
          end
        end

        # The default attributes for the exit this page

        DEFAULT_ATTRIBUTES = { class: 'govuk-exit-this-page', data: { module: 'govuk-exit-this-page' } }.freeze

        private

        # Generates the default HTML for the GOV.UK exit this page component
        #
        # @return [ActiveSupport::SafeBuffer]

        def default_text
          capture do
            concat(tag.span('Emergency', class: 'govuk-visually-hidden'))
            concat(' Exit this page')
          end
        end
      end
    end
  end
end
