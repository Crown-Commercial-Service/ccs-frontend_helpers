require_relative 'link'

module CCS
  module Components
    module CCS
      class Header < Base
        # = CCS Header Service Authentication
        #
        # The individual footer navigation item
        #
        # @!attribute [r] service_authentication_links
        #   @return [Array<Link>] An array of the initialised service authentication links
        # @!attribute [r] container_classes
        #   @return [String] classes for the container

        class ServiceAuthentication
          include ActionView::Context
          include ActionView::Helpers

          private

          attr_reader :service_authentication_links, :container_classes

          public

          # @param service_authentication_items [Array<Hash>] an array of links for the service authentication section.
          #                                                   See {Components::CCS::Header::Link#initialize Link#initialize} for details of the items in the array.
          # @param container_classes [String] classes for the container
          # @param context [ActionView::Base] the view context

          def initialize(service_authentication_items:, context:, container_classes: nil)
            @service_authentication_links = service_authentication_items&.map { |service_authentication_link| Link.new(li_class: 'ccs-header__service-authentication-item', active: false, context: context, **service_authentication_link) }
            @container_classes = container_classes
          end

          # Generates the HTML for the CCS Footer Meta sections
          #
          # @return [ActiveSupport::SafeBuffer]

          def render
            tag.div(class: 'ccs-header__service-authentication') do
              tag.div(class: "ccs-header__service-authentication-container #{container_classes}".rstrip) do
                tag.ul(class: 'ccs-header__service-authentication-list') do
                  service_authentication_links.each { |service_authentication_link| concat(service_authentication_link.render) }
                end
              end
            end
          end
        end
      end
    end
  end
end
