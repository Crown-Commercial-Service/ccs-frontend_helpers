# frozen_string_literal: true

require_relative 'govuk_frontend/accordion'
require_relative 'govuk_frontend/back_link'
require_relative 'govuk_frontend/breadcrumbs'
require_relative 'govuk_frontend/button'
require_relative 'govuk_frontend/character_count'
require_relative 'govuk_frontend/checkboxes'
require_relative 'govuk_frontend/cookie_banner'
require_relative 'govuk_frontend/date_input'
require_relative 'govuk_frontend/details'
require_relative 'govuk_frontend/error_message'
require_relative 'govuk_frontend/error_summary'
require_relative 'govuk_frontend/exit_this_page'
require_relative 'govuk_frontend/fieldset'
require_relative 'govuk_frontend/file_upload'
require_relative 'govuk_frontend/footer'
require_relative 'govuk_frontend/form_group'
require_relative 'govuk_frontend/header'
require_relative 'govuk_frontend/hint'
require_relative 'govuk_frontend/input'
require_relative 'govuk_frontend/inset_text'
require_relative 'govuk_frontend/label'
require_relative 'govuk_frontend/notification_banner'
require_relative 'govuk_frontend/pagination'
require_relative 'govuk_frontend/panel'
require_relative 'govuk_frontend/phase_banner'
require_relative 'govuk_frontend/radios'
require_relative 'govuk_frontend/select'
require_relative 'govuk_frontend/skip_link'
require_relative 'govuk_frontend/step_by_step_navigation'
require_relative 'govuk_frontend/summary_list'
require_relative 'govuk_frontend/table'
require_relative 'govuk_frontend/tabs'
require_relative 'govuk_frontend/tag'
require_relative 'govuk_frontend/task_list'
require_relative 'govuk_frontend/textarea'
require_relative 'govuk_frontend/warning_text'

module CCS
  module FrontendHelpers
    # This module loads in all the GOV.UK Frontend Helper methods.
    # These are a collection of view  to help render GOV.UK components

    module GovUKFrontend
      include Accordion
      include BackLink
      include Breadcrumbs
      include Button
      include CharacterCount
      include Checkboxes
      include CookieBanner
      include DateInput
      include Details
      include ErrorMessage
      include ErrorSummary
      include ExitThisPage
      include FileUpload
      include Fieldset
      include Footer
      include FormGroup
      include Header
      include Hint
      include Input
      include InsetText
      include Label
      include NotificationBanner
      include Pagination
      include Panel
      include PhaseBanner
      include Radios
      include Select
      include SkipLink
      include StepByStepNavigation
      include SummaryList
      include Table
      include Tabs
      include Tag
      include TaskList
      include Textarea
      include WarningText
    end
  end
end
