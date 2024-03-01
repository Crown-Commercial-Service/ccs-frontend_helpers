## Unreleased

### 💥 Breaking changes

Update components to be compatible with GOV.UK Frontend v5.2

For pagination, the option to enable ellipsis is now:
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

### 🏠 Internal changes

Add tests for GOV.UK Frontend fixtures

## [0.1.2] - 2023-11-16

Fix issue with radios component which, when passed a model or form, would treat the value as an array.
This did not cause an issue for strings as the `include?` method still works for them but if the value was a boolean or a number then an error would be thrown.

## [0.1.1] - 2023-10-25

Fix some bugs with various helpers and update dependencies

## [0.1.0] - 2023-02-22

Initial release of CCS Frontend Helpers.
This release contains view helpers that are used to create GOV.UK and CCS components.

The following GOV.UK helpers have been added:

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

The following CCS helpers have been added:

- Dashboard Panels
- Logo
- Header
- Footer
