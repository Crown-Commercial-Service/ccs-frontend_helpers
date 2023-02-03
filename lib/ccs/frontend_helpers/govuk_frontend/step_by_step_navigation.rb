# frozen_string_literal: true

require 'action_view'

require_relative '../shared_methods'

module CCS
  module FrontendHelpers
    module GovUKFrontend
      # = GOV.UK Step by step navigation
      #
      # This helper is used for generating the Step by step navigation component from the
      # {https://design-system.service.gov.uk/patterns/step-by-step-navigation/ GDS - Pages - Step by step navigation}
      #
      # To use this component you need the following from {https://github.com/alphagov/govuk_publishing_components GOV.UK Publishing Components}.
      # For the SCSS components you should add:
      # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/stylesheets/govuk_publishing_components/components/_step-by-step-nav.scss _step-by-step-nav.scss}
      # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/stylesheets/govuk_publishing_components/components/_step-by-step-nav-related.scss _step-by-step-nav-related.scss}
      # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/stylesheets/govuk_publishing_components/components/_step-by-step-nav-header.scss _step-by-step-nav-header.scss}
      # For the JavaScript you should add:
      # - {https://github.com/alphagov/govuk_publishing_components/blob/main/app/assets/javascripts/govuk_publishing_components/components/step-by-step-nav.js step-by-step-nav.js}

      module StepByStepNavigation
        include SharedMethods
        include ActionView::Helpers
        include ActionView::Context

        # Generates the HTML for the GOV.UK Step by step navigation component (experimental)
        #
        # @param step_by_step_sections [Array] the navigation items that will be rendered to the page.
        #                                   See {govuk_step_by_step_navigation_section} for more details
        # @param govuk_step_by_step_navigation_options [Hash] options that will be used in customising the HTML
        #
        # @option govuk_step_by_step_navigation_options [String] :classes additional CSS classes for the step by step navigation HTML
        # @option govuk_step_by_step_navigation_options [Hash] :attributes ({data: { module: 'govuk-step-by-step-navigation', 'show-text': 'Show', 'hide-text': 'Hide', 'show-all-text': 'Show all', 'hide-all-text': 'Hide all' } })
        #                                                                  any additional attributes that will added as part of the HTML
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Step by step navigation
        #                                     which can then be rendered on the page

        def govuk_step_by_step_navigation(step_by_step_sections, **govuk_step_by_step_navigation_options)
          initialise_attributes_and_set_classes(govuk_step_by_step_navigation_options, 'gem-c-step-nav gem-c-step-nav--large gem-c-step-nav--active')
          determine_step_by_step_navigation_attributes(govuk_step_by_step_navigation_options)

          tag.div(**govuk_step_by_step_navigation_options[:attributes]) do
            tag.ol(class: 'gem-c-step-nav__steps') do
              step_by_step_sections.each.with_index(1) { |step_by_step_section, section_index| concat(govuk_step_by_step_navigation_section(step_by_step_section, section_index.to_s)) }
            end
          end
        end

        private

        # The HTML for a section within GOV.UK Step by step navigation, used by {govuk_step_by_step_navigation}
        #
        # @param step_by_step_section [Hash] the parameters that will be used to create the section
        # @param section_index [String] the index of the section
        #
        # @option step_by_step_section [Hash] :heading the paramaters for the section heading,
        #                                              see {govuk_step_by_step_navigation_heading} for more details
        # @option step_by_step_section [Array] :content the paramaters for the section content,
        #                                               see {govuk_step_by_step_navigation_content} for more details
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Step by step navigation section
        #                                     which is used in {govuk_step_by_step_navigation}

        def govuk_step_by_step_navigation_section(step_by_step_section, section_index)
          section_id = convert_to_id(step_by_step_section[:heading][:text])

          tag.li(class: 'gem-c-step-nav__step js-step', id: section_id) do
            concat(govuk_step_by_step_navigation_heading(step_by_step_section[:heading], section_index))
            concat(govuk_step_by_step_navigation_content(step_by_step_section[:content], section_id, section_index))
          end
        end

        # The HTML for a section heading within GOV.UK Step by step navigation, used by {govuk_step_by_step_navigation_section}
        #
        # @param section_heading [Hash] the parameters that will be used to create the heading
        # @param section_index [String] the index of the section
        #
        # @option section_heading [Hash] :text text for the section heading
        # @option section_heading [Hash] :logic (nil) text to show instead of a number in the sidebar
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Step by step navigation section heading
        #                                     which is used in {govuk_step_by_step_navigation_section}

        def govuk_step_by_step_navigation_heading(section_heading, section_index)
          logic = section_heading[:logic]

          tag.div(class: 'gem-c-step-nav__header js-toggle-panel', data: { position: section_index }) do
            tag.h2(class: 'gem-c-step-nav__title') do
              concat(tag.span(class: "gem-c-step-nav__circle gem-c-step-nav__circle--#{logic ? 'logic' : 'number'}") do
                tag.span(class: 'gem-c-step-nav__circle-inner') do
                  tag.span(class: 'gem-c-step-nav__circle-background') do
                    concat(tag.span('Step', class: 'govuk-visually-hidden'))
                    concat(logic || section_index)
                  end
                end
              end)
              concat(tag.span(class: 'js-step-title') do
                tag.span(section_heading[:text], class: 'js-step-title-text')
              end)
            end
          end
        end

        # The HTML for a section content within GOV.UK Step by step navigation, used by {govuk_step_by_step_navigation_section}
        #
        # @param content [Array] an array of the content items that will be rendered within the section.
        #                        Only two types of content are allowed:
        #                        - +:paragraph+ - see {govuk_step_by_step_navigation_paragraph}
        #                        - +:list+ - see {govuk_step_by_step_navigation_list}
        # @param section_id [String] the id of the section
        # @param section_index [String] the index of the section
        #
        # @option content [Symbol] :type the type of content, either +:paragraph+ or +list+
        # @option content [Symbol] :text the text for the paragraph. Ignored unless the +type+ is +:list+
        # @option content [Symbol] :items the items for the list. Ignored unless the +type+ is +:paragraph+
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the GOV.UK Step by step navigation section content
        #                                     which is used in {govuk_step_by_step_navigation_section}

        def govuk_step_by_step_navigation_content(content, section_id, section_index)
          tag.div(class: 'gem-c-step-nav__panel js-panel', id: "step-panel-#{section_id}-#{section_index}") do
            content.each do |element|
              concat(
                case element[:type]
                when :paragraph
                  govuk_step_by_step_navigation_paragraph(element[:text])
                when :list
                  govuk_step_by_step_navigation_list(element[:items])
                end
              )
            end
          end
        end

        # The HTML for the paragraph item within the GOV.UK Step by step navigation content, used by {govuk_step_by_step_navigation_content}
        #
        # @param text [String] the text for the paragraph
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the paragraph
        #                                     which is used in {govuk_step_by_step_navigation_content}

        def govuk_step_by_step_navigation_paragraph(text)
          tag.p(
            text,
            class: 'gem-c-step-nav__paragraph',
          )
        end

        # The HTML for the list items within the GOV.UK Step by step navigation content, used by {govuk_step_by_step_navigation_content}
        #
        # @param items [Array] an array of the list items,
        #                      see {govuk_step_by_step_navigation_list_item} for more details
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the list
        #                                     which is used in {govuk_step_by_step_navigation_content}

        def govuk_step_by_step_navigation_list(items)
          tag.ul(class: 'gem-c-step-nav__list gem-c-step-nav__list--choice', data: { length: items.length.to_s }) do
            items.each do |item|
              concat(govuk_step_by_step_navigation_list_item(item[:text], item[:no_marker]))
            end
          end
        end

        # The HTML for a list item, used by {govuk_step_by_step_navigation_list}
        #
        # @param text [Symbol] the text of the list item
        # @param no_marker [Symbol] (nil) switch to hide the bullet marker
        #
        # @return [ActiveSupport::SafeBuffer] the HTML for the list item
        #                                     which is used in {govuk_step_by_step_navigation_list}

        def govuk_step_by_step_navigation_list_item(text, no_marker)
          list_item_classes = ['gem-c-step-nav__list-item js-list-item']
          list_item_classes << 'gem-c-step-nav__list--no-marker' if no_marker

          tag.li(class: list_item_classes) do
            tag.span(text)
          end
        end

        # Converts the title text into a string to be used as the section id
        #
        # @param title [String] the section title that will be converted
        #
        # @return [String] the section id

        def convert_to_id(title)
          title.downcase.gsub(' ', '-').gsub('(', '').gsub(')', '')
        end

        # Generates a hash with the attributes used in {govuk_step_by_step_navigation}
        #
        # @param govuk_step_by_step_navigation_options [Hash] options that will be used in customising the HTML
        #
        # @option (see govuk_step_by_step_navigation)
        #
        # @return [Hash] contains the HTMl attributes used in {govuk_step_by_step_navigation}

        def determine_step_by_step_navigation_attributes(govuk_step_by_step_navigation_options)
          set_data_module(govuk_step_by_step_navigation_options, 'govuk-step-by-step-navigation')

          DEFAULT_SHOW_HIDE_TEXT.each { |key, value| govuk_step_by_step_navigation_options[:attributes][:data][key] ||= value }
        end

        # Default text for the show and hide buttons which are part of each section

        DEFAULT_SHOW_HIDE_TEXT = { 'show-text': 'Show', 'hide-text': 'Hide', 'show-all-text': 'Show all', 'hide-all-text': 'Hide all' }.freeze
      end
    end
  end
end
