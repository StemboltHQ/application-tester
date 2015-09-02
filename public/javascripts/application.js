$(document).ready(function() {
  $("form#domain_tests").submit(function(e) {
    e.preventDefault();

    $.ajax({
      type: "POST",
      url: "/application-test",
      data: $(event.target).serialize(),
      success: function(result) {
      $("#domain_test_results").html(result);
      }
    });
  });
  $("form#markup_test").submit(function(e) {
    e.preventDefault();

    $.ajax({
      type: "POST",
      url: "/markup-test",
      data: $(event.target).serialize(),
      success: function(result) {
      $("#markup_test_results").html(result);
      }
    });
  });
});
