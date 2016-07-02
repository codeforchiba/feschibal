var yaml = require("js-yaml");
var fs = require("fs");
var env = yaml.load(fs.readFileSync("env.yml"));
var express = require('express');

var app = express();

var config;
if (app.get('env') === 'production') {
  config = env.production;
} else if (app.get('env') === 'staging') {
  config = env.staging;
} else {
  config = env.development;
}

module.exports = config;
