// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs

var MAX_NUMBER_IDS = 3 ;
function add_show_updates_button(){
   if ($('#twitter-ids ul li').size() == MAX_NUMBER_IDS ) {
    $('#show-updates').show();
   } else {
    $('#show-updates').hide();
   }
}
$(document).ready(function(){
  $('#add-ids').bind('click', function(){
    var username = $('#username').val();
    var total_size = $('#twitter-ids ul li').size();
    if ( total_size < MAX_NUMBER_IDS) {
      $('#twitter-ids ul').append("<li>"+username+" <a class='remove-id' href='#'>remove item</a>"+"<input type='hidden' name='usernames["+username+"]' value='"+username+"'/></li>");

    }
    add_show_updates_button();
  });

  $('.remove-id').live('click', function(e){
    $(this).parent().remove();
    add_show_updates_button();
    e.preventDefault();
  });
  $('#spinner').append("<img src='/assets/spinner.gif' />");
  $('#spinner').hide();
  var toggleLoading = function() { $("#spinner").toggle() } ;
  $('#get-updates-form').bind("ajax:beforeSend",  toggleLoading);
  $('#get-updates-form').bind("ajax:complete", toggleLoading);
});
