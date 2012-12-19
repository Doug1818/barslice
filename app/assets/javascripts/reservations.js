$(function () {
  $('.edit_reservation input[type=submit]').remove();
  $('.edit_reservation input[type=checkbox]').click(function () {
    $(this).parent('form').submit();
  });  
});