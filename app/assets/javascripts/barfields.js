$(document).ready(function(){
//Hide div w/id extra
$(“#signupform”).css(“display”,”none”);
// Add onclick handler to checkbox w/id checkboxid
$(“#isbarbtn”).click(function(){
// If checked
if ($(“#isbarbtn”).is(“:checked”))
{
//show the hidden div
$(“#signupform”).show(“fast”);
}
else
{
//otherwise, hide it
$(“#signupform”).hide(“fast”);
}
});
});



//$(document).ready(function() {

// $('#signup-form').hide(); //Initially form wil be hidden.

//  $('#isbar-btn').click(function() {
//   $('#signup-form').show();//Form shows on button click

//   });
// });

//function checkUncheck() { 
//    $('#isbar-btn').click(function() {
//        if ( $('#isbar-btn:checked').length > 0) {
//            $("#signup-form").show();
//        } else {
//            $("#signup-form").hide();
//        }
//    }); 
//}

//$(document).ready(function() {

// $('#signup-form').hide(); //Initially form wil be hidden.

//  $('#isbar-btn').click(function() {
//   $('#signup-form').show();//Form shows on button click

//   });
// });