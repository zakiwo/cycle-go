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
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function () { // このコードを追加する
  $(function () {
    $('.js-text_field').on('keyup', function () {
      var word = $.trim($(this).val());
      $.ajax({
        type: 'GET',
        url: '/incremental_search',
        data: { word: word }, //("title=" + title),
        dataType: 'json'
      })
      .done(function (data) {
        console.log(data);
        $('.js-messages li').remove();
        $(data).each(function (i, message) {
          $('.js-messages').append(`<li class="message"><a data-turbolinks="false", href="/roads/${message.id}">${message.name}</a></li>`);
        });
      })
    });
  });
}); // このコードを追加する