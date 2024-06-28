# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Update to CCS Frontend v1.1

- The following CCS helpers have been added:
  - Contact Us
  - Password Strength

## [1.0.0] - 2024-06-07

### Changed

- First major release of gem
- Internal change to use CCS Frontend fixtures to test the CCS frontend components.
  This included some minor changes to the HTML for the components.

## [0.4.0] - 2024-05-20

### Added

- Update components to be compatible with GOV.UK Frontend v5.4

## [0.3.0] - 2024-04-12

### Added

- Update components to be compatible with GOV.UK Frontend v5.3
- The following GOV.UK helpers have been added:
  - Password input

## [0.2.0] - 2024-03-13

### Changed

- Update components to be compatible with GOV.UK Frontend v5.2
- For pagination, the option to enable ellipsis is now:
  ```ruby
  {
    ellipsis: true
  }
  ```
  instead of:
  ```ruby
  {
    type: :ellipsis
  }
  ```
- Add tests for GOV.UK Frontend fixtures

### Added

- The following GOV.UK helpers have been added:
  - Exit this page
  - Task list

## [0.1.2] - 2023-11-16

### Fixed

- Fix issue with radios component which, when passed a model or form, would treat the value as an array.
  This did not cause an issue for strings as the `include?` method still works for them but if the value was a boolean or a number then an error would be thrown.

## [0.1.1] - 2023-10-25

### Fixed

- Fix some bugs with various helpers and update dependencies

## [0.1.0] - 2023-02-22

### Added

- Initial release of CCS Frontend Helpers.
  This release contains view helpers that are used to create GOV.UK and CCS components.

- The following GOV.UK helpers have been added:
  - Accordion
  - Back link
  - Breadcrumbs
  - Button
  - Character count
  - Checkboxes
  - Cookie banner
  - Date input
  - Details
  - Error message
  - Error summary
  - Fieldset
  - File upload
  - Footer
  - Form group
  - Header
  - Hint
  - Inset text
  - Notification banner
  - Pagination
  - Panel
  - Phase banner
  - Radios
  - Select
  - Skip link
  - Step by step navigation
  - Summary list
  - Table
  - Tabs
  - Tag
  - Text input
  - Textarea
  - Warning text

- The following CCS helpers have been added:
  - Dashboard Panels
  - Logo
  - Header
  - Footer
