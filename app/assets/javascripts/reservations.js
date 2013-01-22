$(function () {
  $('.ajax_check_box input[type=submit]').remove();
  $('.ajax_check_box input[type=checkbox]').click(function () {
    $(this).parent('form').submit();
  });  
});