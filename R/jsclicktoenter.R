jsclicktoenter <- function(send, chatboxid, message_field){

  first <- "shinyjs.init = function() {
  // Sending on ENTER
  jQuery(document).ready(function(){
  jQuery('#"

  second <- "').keypress(function(evt){
  if (evt.keyCode == 13){
  // Enter, simulate clicking send
  jQuery('#"



  third <- "').click();
  }
  });
  });

  // Scrolling down
  var oldContent = null;
  window.setInterval(function() {
  var elem = document.getElementById('"

fourth <- "');
if (oldContent != elem.innerHTML){
scrollToBottom();
}
oldContent = elem.innerHTML;
  }, 300);

function scrollToBottom(){
var elem = document.getElementById('chatbox');
elem.scrollTop = elem.scrollHeight;
}
}"

  jscode <- paste0(first, message_field, second, send, third,chatboxid,fourth)

  return(jscode)
}
