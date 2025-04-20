$(document).ready(function () {
  console.log("new EVENT");

  // date time picker

  $("#event_start_date, #event_end_date").daterangepicker({
    timePicker24Hour: true,
    singleDatePicker: true,
    timePicker: true,
    showDropdowns: true,
    timePickerIncrement: 15,
    startDate: moment().startOf("hour"),
    locale: {
      format: "DD.MM.YYYY HH:mm",
      separator: " - ",
      applyLabel: "Принять",
      cancelLabel: "Отмена",
      fromLabel: "С",
      toLabel: "По",
      customRangeLabel: "Custom",
      weekLabel: "W",
      daysOfWeek: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"],
      monthNames: [
        "Январь",
        "Февраль",
        "Март",
        "Апрель",
        "Май",
        "Июнь",
        "Июль",
        "Август",
        "Сентябрь",
        "Октябрь",
        "Ноябрь",
        "Декабрь",
      ],
      firstDay: 1,
    },
  });

  var zoom = 4;
  var coord = {
    lat: 59,
    lng: 87,
  };

  var marker = L.marker([coord.lat, coord.lng]);

  map = L.map("map", {
    center: [59, 87],
    zoom: zoom,
    attributionControl: false,
  });

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 23,
  }).addTo(map);

  map.on("click", (event) => {
    $("#event_location").val([event.latlng.lng, event.latlng.lat].join(" "));

    fetch(
      `https://api.geoapify.com/v1/geocode/reverse?lat=${event.latlng.lat}&lon=${event.latlng.lng}&lang=ru&apiKey=3cbba0dac3564cb590445ae60cc44eea`,
      { method: "GET" }
    )
      .then((response) => response.json())
      .then((result) =>
        $("#event_location_name").val(result.features[0].properties.formatted)
      )
      .catch((error) => console.log("error", error));

    newLatLng = new L.LatLng(event.latlng.lat, event.latlng.lng);
    marker.setLatLng(newLatLng);
  });

  marker.addTo(map);
});
