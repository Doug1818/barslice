
$(function() {
  return $('#new_charge').submit(function() {
    $('input[type=submit]').attr('disabled', true);
    if (isNumber($('#charge_amount').val()) == false && $('#charge_reason').val() == "") {
      $('#amount_error').text("Please enter a valid charge amount");
      $('#reason_error').text("Please select a reason");
      $('input[type=submit]').attr('disabled', false);
      return false;
    } else if (isNumber($('#charge_amount').val()) == false) {
      $('#amount_error').text("Please enter a valid charge amount");
      $('input[type=submit]').attr('disabled', false);
      return false;
    } else if ($('#charge_reason').val() == "") {
      $('#reason_error').text("Please select a reason");
      $('input[type=submit]').attr('disabled', false);
      return false;
    } else {
      return true;
    }
  });
});

function isNumber(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}