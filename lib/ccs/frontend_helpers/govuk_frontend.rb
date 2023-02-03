# frozen_string_literal: true

require_relative 'govuk_frontend/accordion'
require_relative 'govuk_frontend/back_link'
require_relative 'govuk_frontend/breadcrumbs'
require_relative 'govuk_frontend/button'
require_relative 'govuk_frontend/cookie_banner'
require_relative 'govuk_frontend/details'
require_relative 'govuk_frontend/error_message'
require_relative 'govuk_frontend/error_summary'
require_relative 'govuk_frontend/field'
require_relative 'govuk_frontend/field/character_count'
require_relative 'govuk_frontend/field/checkboxes'
require_relative 'govuk_frontend/field/date_input'
require_relative 'govuk_frontend/field/file_upload'
require_relative 'govuk_frontend/field/input'
require_relative 'govuk_frontend/field/select'
require_relative 'govuk_frontend/field/textarea'
require_relative 'govuk_frontend/field/radios'
require_relative 'govuk_frontend/fieldset'
require_relative 'govuk_frontend/footer'
require_relative 'govuk_frontend/form_group'
require_relative 'govuk_frontend/header'
require_relative 'govuk_frontend/hint'
require_relative 'govuk_frontend/inset_text'
require_relative 'govuk_frontend/label'
require_relative 'govuk_frontend/notification_banner'
require_relative 'govuk_frontend/pagination'
require_relative 'govuk_frontend/panel'
require_relative 'govuk_frontend/phase_banner'
require_relative 'govuk_frontend/skip_link'
require_relative 'govuk_frontend/step_by_step_navigation'
require_relative 'govuk_frontend/summary_list'
require_relative 'govuk_frontend/table'
require_relative 'govuk_frontend/tabs'
require_relative 'govuk_frontend/tag'
require_relative 'govuk_frontend/warning_text'

module CCS
  module FrontendHelpers
    # This module loads in all the GOV.UK Frontend Helper methods.
    # These are a collection of view helpers to help render GOV.UK components

    module GovUKFrontend
      include Accordion
      include BackLink
      include Breadcrumbs
      include Button
      include CookieBanner
      include Details
      include ErrorMessage
      include ErrorSummary
      include Field
      include Field::CharacterCount
      include Field::Checkboxes
      include Field::DateInput
      include Field::FileUpload
      include Field::Input
      include Field::Radios
      include Field::Select
      include Field::Textarea
      include Fieldset
      include Footer
      include FormGroup
      include Header
      include Hint
      include InsetText
      include Label
      include NotificationBanner
      include Pagination
      include Panel
      include PhaseBanner
      include SkipLink
      include StepByStepNavigation
      include SummaryList
      include Table
      include Tabs
      include Tag
      include WarningText
    end
  end
end
