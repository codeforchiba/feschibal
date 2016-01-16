var express = require('express');
var router = express.Router();
var env = require('../app_server/env');
var debug = require('debug')('feschibal:index');

/* GET home page. */
router.get('/', function(req, res, next) {
  var weatherData = [{a:"b"}];
  res.render('index', { weatherData: weatherData });
});

module.exports = router;
