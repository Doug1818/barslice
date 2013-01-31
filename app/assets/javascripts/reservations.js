$(function () {
  $('.ajax_check_box input[type=submit]').remove();
  $('.ajax_check_box input[type=checkbox]').click(function () {
    $(this).parent('form').submit();
  });  
});

$(function () {
	$('#togglediv').click(function(){
	  $('#more_specials').toggle();
	  $(this).text($(this).text() == 'More' ? 'Fewer' : 'More');
	});
});