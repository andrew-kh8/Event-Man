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
  });

  L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution:
      '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    maxZoom: 23,
  }).addTo(map);

  var wfs_hunter_layer = L.Geoserver.wfs("http://0.0.0.0:8080/geoserver/wfs", {
    layers: "event_man:events",
  });

  map.on("click", (event) => {
    $("#event_location").val([event.latlng.lat, event.latlng.lng].join(" "));
    console.log([event.latlng.lat, event.latlng.lng].join(" "));
  });

  wfs_hunter_layer.addTo(map);
});
