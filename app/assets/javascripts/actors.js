$(function() {
  $('#actor_search').focus();
  $('.tt-query').css('background-color','#fff');
  return $('#actor_search').typeahead({
    name: "actor",
    remote: "/etsy/autocomplete?query=%QUERY"
  });
});
