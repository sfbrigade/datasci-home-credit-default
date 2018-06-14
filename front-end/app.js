function onMapClick(event) {
    var marker = L.marker(event.latlng).addTo(mymap);
}

var tileOpts = {
    attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
    maxZoom: 15,
    id: "mapbox.streets",
    accessToken: 'pk.eyJ1Ijoia3V5ZWhhcmEiLCJhIjoiY2l5bnZsbm5mMDAyNTRlbnpwbnpra2lwbyJ9.DmBIXGUHlZpZpU_MI8uMQQ',
};

// initialize map
var mymap = L.map("mapid").setView([36, -97], 4);

// add tiles to map
L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', tileOpts)
    .addTo(mymap);

// different objects to add to map
var marker = L.marker([36, -97]);

var circle = L.circle([45, -122], {
    color: "purple",
    fillColor: "yellow",
    fillOpacity: 0.5,
    radius: 100000,
}).addTo(mymap);

var polygon = L.polygon([
    [24, -80],
    [30, -81],
    [30, -87]
], {
    color: "green",
    fillColor: "yellow",
    fillOpacity: 1,
}).addTo(mymap);


// popups
marker.bindPopup("<b>Hello world!</b><br>I am a popup.").openPopup();
circle.bindPopup("<i>I</i> am a <i>circle.</i>");
polygon.bindPopup("I <br>am<br>a<br>polygon");

var popup = L.popup()
    .setLatLng([35, -86])
    .setContent("I am a standalone popup.")
    .openOn(mymap);

// events
mymap.on("click", onMapClick);
