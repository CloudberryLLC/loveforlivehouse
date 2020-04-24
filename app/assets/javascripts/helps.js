$(function(){
  $("#search_box").val('<%= @category %>');
});

$("#search_box").on("change", function(){
  $('#search_form').find('[type="submit"]').trigger('click');
});
