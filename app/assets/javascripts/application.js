// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require popper
//= require toastr
//= require bootstrap-sprockets
//= require underscore
//= require gmaps/google
//= require bootstrap-toggle
//= require jquery.jpostal
//= require jquery.raty
//= require Chart.min
//= require trix
//= require turbolinks
//= require activestorage
//= require_tree .


//ヘルプ検索
$(document).on('turbolinks:load', function(){

  $(document).on('keyup', '#search-input', function(e){
    e.preventDefault();
    var input = $.trim($(this).val());
    if (input == "") {
      $('#search-result').find('a').remove();
    }else{
      $.ajax({
      url: '/search/help',
      type: 'GET',
      data: ('keyword=' + input),
      processData: false,
      contentType: false,
      dataType: 'json'
      })

      .done(function(data){
        console.log(data);
        $('#search-result').find('a').remove();
        $(data).each(function(i, help){
          $('#search-result').append(ShowSearchResult(help))
        });
      })

      .fail(function(){
        alert('検索中にエラーが発生しました');
      })
    }

  });
});

function ShowSearchResult(help) {
 var html =
 '<a href="/helps/' + help.id + '" target="blank" class="no_decoration">' +
  '<li class="list-group-item">' +
  help.title + '</li>' + '</a>'
 ;
 return html;
}
