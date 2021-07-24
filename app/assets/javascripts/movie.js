$(document).on('turbolinks:load', function() {
  $('.movie-evaluation').html('<strong>評価：</strong>')
  $('.movie-evaluation').raty({
    readOnly: true,
    score: function() {
      return $(this).attr('data-score');
    },
    path: '/assets/'
  });

});