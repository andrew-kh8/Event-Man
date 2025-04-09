$(document).ready(function () {
  console.log("new EVENT 1");

  var zoom = 4;
  var coord = {
    lat: 59,
    lng: 87,
  };

  map = L.map("map", {
    center: [59, 87],
    zoom: zoom,
    attributionControl: false,
  });

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    maxZoom: 23,
  }).addTo(map);

  L.Control.geocoder().addTo(map);

  var event_layer = L.Geoserver.wfs("http://0.0.0.0:8080/geoserver/wfs", {
    layers: "event_man:events",
  });

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

    marker = L.marker([event.latlng.lat, event.latlng.lng]).addTo(map);
  });

  event_layer.addTo(map);
});
