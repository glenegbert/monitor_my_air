$(document).ready(function(){

  $("#nbutton").click(hide_index)
  $("#nbutton").click(show_form)
  

  function hide_index(){
    $("#notifications-index").hide()
    }
  function show_form(){
    $("#new-notification-form").show()
  }

})
