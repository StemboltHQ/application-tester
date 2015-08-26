$(document).ready(function() {
  $("form#redirection").submit(function(e) {
    e.preventDefault();

    $.ajax({
      type: "POST",
      url: "/redirection-test",
      data: $(event.target).serialize(),
      success: function(result) {
      $("#test_results").html(result);
      }
    });
  });
});
