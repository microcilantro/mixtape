// Namespace for the application
var app = app || {};

// Use mustache-style syntax for underscore templates
_.templateSettings = {
  interpolate: /\{\{(.+?)\}\}/g
};

$(document).ready(function() {
  // Use MAPBOX_STYLE_ID from environment variable (injected by server)
  var mapboxStyleId = window.MAPBOX_STYLE_ID || 'mapbox/streets-v11';
  
  var options = { tileLayer: { detectRetina: true } };
  app.leaflet = L.mapbox.map('map', mapboxStyleId, options);
  
  // Feedback View that we want visible at all times
  var feedbackView = new app.FeedbackView();
  $('body').append(feedbackView.render().el);

  app.router = new app.Router();
});
