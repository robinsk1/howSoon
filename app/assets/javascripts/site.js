$(document).ready(function() {
var toggleLoading = function() { $("#loading").toggle() };
  $("#get_tweets")
    .bind("ajax:beforeSend", function() {$('#loading').show("slow");})
    .bind("ajax:success", function(event, data, status, xhr) {
          $("#tweets").html(data);
        })
    .bind("ajax:failure", function() {alert("failure!");})
    .bind("ajax:complete", function() {$('#loading').hide("slow");});
});
