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
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require semantic-ui
//= require calendar
//= require highcharts
//= require chartkick


$(document).on('turbolinks:load', function() {

  // Set Locale for Calendar
  var monthsDefault = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

  switch (locale) {
    case 'ru':
      var days = ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];
      var months = ['Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь'];
      var monthsShort = ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'];
      var formatter = {
        date: function (date, settings) {
          if (!date) return '';
          var day = date.getDate().toString();
          var month = (date.getMonth() + 1).toString();
          var year = date.getFullYear().toString();
          return (day.length == 1 ? '0' + day : day) + '.' + (month.length == 1 ? '0' + month : month) + '.' + year;
        }
      };
      break;
    case 'en':
    default:
      var formatter = {};
      break;
  };

  // Semantic UI Dropdown
  $(".ui.dropdown").dropdown();

  // Semantic UI Checkbox
  $(".ui.checkbox").checkbox();

  // Semantic UI Modal
  $("#show_countries, #show_infected_machines").click(function( event ) {
    event.preventDefault();
    $('.ui.modal').modal('show');
  });

  // Svodka
  // if country field present?
  if ($("#country").val()) {

    // Show country select field (remember)
    $(".country_select").show();

    // Checkbox is checked (remember)
    $("#include_country_input").find('input').attr("checked", true);

  } else {
    $(".country_select").hide();
  }

  $("#include_country_input").click(function() {
    ($(this).find('input').is(':checked')) ? $(".country_select").show("fast") : $(".country_select").hide("fast");
  });

  // Semantic UI Message
  $('.message .close').on('click', function() {
    $(this).closest('.message').transition('fade');
  });

  // Calendar
  $('.datepicker').calendar({
    firstDayOfWeek: 1,
    ampm: false,
    type: 'date',
    monthFirst: false,
    text: {
      days: days,
      months: months,
      monthsDefault: monthsDefault,
      monthsShort: monthsShort
    },
    formatter: formatter
  });
});
