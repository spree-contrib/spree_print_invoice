$ ->
  storage_path_field = $('#storage_path')

  $('#store_pdf').click ->
    storage_path_field.prop('disabled', !$(this).prop('checked'))
