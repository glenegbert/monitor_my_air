$(document).ready(function(){

  $("#nbutton").click(hide_index)
  $("#nbutton").click(show_form)


  function hide_index(){
    $("#notifications-index").fadeOut(900)
    }
  function show_form(){
    $("#new-notification-form").delay(900).fadeIn(1000)
  }

})
