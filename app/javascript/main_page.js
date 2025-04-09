$(document).ready(function () {
  var zoom = 4;
  var coord = {
    lat: 59,
    lng: 87,
  };

  map = L.map("map", {
    center: [coord.lat, coord.lng],
    zoom: zoom,
    attributionControl: false,
  });

  event_points = L.Geoserver.wfs("http://0.0.0.0:8080/geoserver/wfs", {
    layers: "event_man:events",
    onEachFeature: function (feature, layer) {

      layer.bindPopup(
        `<a href='/organizations/${feature.properties.organization_id}/events/${feature.id.split('.')[1]}' data-turbo='false'>Посмотреть мероприятие</a>`
      );

      layer
        .bindTooltip(
          feature.properties.name,
          { permanent: false }
        )
        .openTooltip();
    },
  });

  event_points.addTo(map);

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 23,
  }).addTo(map);
});
