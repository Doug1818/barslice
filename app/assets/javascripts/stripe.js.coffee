$ ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

subscription =
  setupForm: ->
    $('.edit_reservation').submit ->
      $('input[type=submit]').attr('disabled', true)
      if $('#editcard').length > 0 && !$("#card_number").val().length
        if !$('#reservation_respolicy_accepted').is(":checked")
          $('#respolicy_error').text("Reservation policy must be accepted")
          $('input[type=submit]').attr('disabled', false)
          false
        else  
          true
      else
        subscription.processCard()
        false
  
  processCard: ->
    card =
      number: $('#card_number').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      if !$('#reservation_respolicy_accepted').is(":checked")
        $('#respolicy_error').text("Reservation policy must be accepted")
        $('input[type=submit]').attr('disabled', false)
      else
        $('#reservation_stripe_card_token').val(response.id)
        $('.edit_reservation')[0].submit()
    else
      if !$('#reservation_respolicy_accepted').is(":checked")
        $('#respolicy_error').text("Reservation policy must be accepted")
      $('#stripe_error').text(response.error.message)
      $('input[type=submit]').attr('disabled', false)