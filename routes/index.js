var express = require('express');
var router = express.Router();
var env = require('../app_server/env');
var debug = require('debug')('feschibal:index');
var request = require('request');

/* GET home page. */
router.get('/', function(req, res, next) {
  var url = env.url.weather.url;
  var cityCode = env.url.weather.cityCode;
  var apikey = process.env.APIKEY;

  var path = url + "?code=" + cityCode + "&key=" + apikey;
  debug("weather path:" + path);

  var options = {
    url: path,
    json: true
  };

  request.get(options, function (error, response, body) {
    var weatherData;
    if(!error && body.status === 'success'){
      weatherData = body;
    }
    res.render('index', { weatherData: weatherData });
  });
});

module.exports = router;
