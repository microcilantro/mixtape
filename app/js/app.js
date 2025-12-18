// Namespace for the application
var app = app || {};

// Use mustache-style syntax for underscore templates
_.templateSettings = {
  interpolate: /\{\{(.+?)\}\}/g
};

$(document).ready(function() {
  var options = { tileLayer: { detectRetina: true } };
  app.leaflet = L.mapbox.map('map', 'pk.eyJ1IjoiZ2hld2l0dCIsImEiOiJjbGJkOHV0NDcwMjlvNDFtejVjZzZrbzNvIn0.66yJSxG8vmOwX2UpQd4Pag', options);
  
  // Feedback View that we want visible at all times
  var feedbackView = new app.FeedbackView();
  $('body').append(feedbackView.render().el);

  app.router = new app.Router();
});
