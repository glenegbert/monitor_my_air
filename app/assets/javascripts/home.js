$(document).ready(function(){

  // $("#rbtn").click(hide_form)

  function hide_form(){
    $('#home-form').hide()
  }
  function show_form_report(){
    $("#new-notification-form").show()
  }

  var $loading = $('#loadingDiv').hide();
  $(document)
  .ajaxStart(function () {
    $loading.show();
  })
  .ajaxStop(function () {
    $loading.hide();
  });
})
