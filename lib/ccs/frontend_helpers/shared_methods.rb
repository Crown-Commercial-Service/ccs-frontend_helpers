# frozen_string_literal: true

module CCS
  module FrontendHelpers
    # This module contains methods that are shared between the helpers

    module SharedMethods
      # Initialises the attributes and sets the class attribute for a helper
      #
      # @param options [Hash] the options for a helper
      # @param default_class [String] the default class for a helper

      def initialise_attributes_and_set_classes(options, default_class)
        (options[:attributes] ||= {})[:class] = "#{default_class} #{options[:classes]}".rstrip
      end

      # Initialises the data-module attribute for a helper
      #
      # @param options [Hash] the options for a helper
      # @param data_module [String] the name of the data module

      def set_data_module(options, data_module)
        (options[:attributes][:data] ||= {})[:module] = data_module
      end
    end
  end
end
