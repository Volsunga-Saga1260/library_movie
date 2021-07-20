$(document).on('turbolinks:load', function() {
  $('.movie-evaluation').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });

});