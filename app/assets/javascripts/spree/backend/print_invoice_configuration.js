$(function() {
  var storage_path_field;
  storage_path_field = $('#storage_path');
  return $('#store_pdf').click(function() {
    return storage_path_field.prop('disabled', !$(this).prop('checked'));
  });
});
