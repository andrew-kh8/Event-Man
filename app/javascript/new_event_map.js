$(document).ready(function () {
  console.log("new EVENT 1");

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

    newLatLng = new L.LatLng(event.latlng.lat, event.latlng.lng);
    marker.setLatLng(newLatLng);
  });

  event_layer.addTo(map);
  marker.addTo(map);

  // minimal configure
  new Autocomplete("event_location_name", {
    // default selects the first item in
    // the list of results
    selectFirst: true,

    // The number of characters entered should start searching
    howManyCharacters: 2,

    // onSearch
    onSearch: ({ currentValue }) => {
      // You can also use static files
      // const api = '../static/search.json'
      const api = `https://nominatim.openstreetmap.org/search?format=geojson&limit=5&city=${encodeURI(
        currentValue
      )}`;

      /**
       * jquery
       */
      // return $.ajax({
      //     url: api,
      //     method: 'GET',
      //   })
      //   .done(function (data) {
      //     return data
      //   })
      //   .fail(function (xhr) {
      //     console.error(xhr);
      //   });

      // OR -------------------------------

      /**
       * axios
       * If you want to use axios you have to add the
       * axios library to head html
       * https://cdnjs.com/libraries/axios
       */
      // return axios.get(api)
      //   .then((response) => {
      //     return response.data;
      //   })
      //   .catch(error => {
      //     console.log(error);
      //   });

      // OR -------------------------------

      /**
       * Promise
       */
      return new Promise((resolve) => {
        fetch(api)
          .then((response) => response.json())
          .then((data) => {
            resolve(data.features);
          })
          .catch((error) => {
            console.error(error);
          });
      });
    },
    // nominatim GeoJSON format parse this part turns json into the list of
    // records that appears when you type.
    onResults: ({ currentValue, matches, template }) => {
      const regex = new RegExp(currentValue, "gi");

      // if the result returns 0 we
      // show the no results element
      return matches === 0
        ? template
        : matches
            .map((element) => {
              return `
          <li class="loupe">
            <p>
              ${element.properties.display_name.replace(
                regex,
                (str) => `<b>${str}</b>`
              )}
            </p>
          </li> `;
            })
            .join("");
    },

    // we add an action to enter or click
    onSubmit: ({ object }) => {
      const [lng, lat] = object.geometry.coordinates;

      newLatLng = new L.LatLng(lat, lng);
      marker.setLatLng(newLatLng);
      map.setView([lat, lng], 8);
    },

    // get index and data from li element after
    // hovering over li with the mouse or using
    // arrow keys ↓ | ↑
    onSelectedItem: ({ index, element, object }) => {
      console.log("onSelectedItem:", index, element, object);
    },

    // the method presents no results element
    noResults: ({ currentValue, template }) =>
      template(`<li>No results found: "${currentValue}"</li>`),
  });
});
