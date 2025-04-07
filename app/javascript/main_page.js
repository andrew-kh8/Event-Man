$(document).ready(function () {
  var zoom = 4;
  var coord = {
    lat: 59,
    lng: 87,
  };

  map = L.map("map", {
    center: [coord.lat, coord.lng],
    zoom: zoom,
  });

  event_points = L.Geoserver.wfs("http://0.0.0.0:8080/geoserver/wfs", {
    layers: "event_man:events",
    onEachFeature: function (feature, layer) {
      console.log(1);
    },
  });

  event_points.addTo(map);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution:
      '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    maxZoom: 23,
  }).addTo(map);
});
