$(document).ready(function() {
var toggleLoading = function() { $("#loading").toggle() };
  $("#get_tweets")
    .bind("ajax:beforeSend", function() {hideLinks();})
    .bind("ajax:success", function(event, data, status, xhr) {
          $("#tweets_container").html(data);
        })
    .bind("ajax:failure", function() {alert("failure!");})
    .bind("ajax:complete", function() {DoTweets()});


function hideLinks(){
$('#loading').show("slow");
$('#link').hide("slow");
}

});
