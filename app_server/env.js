var yaml = require("js-yaml");
var fs = require("fs");
var env = yaml.load(fs.readFileSync("env.yml"));
var express = require('express');

var app = express();

var config;
if (app.get('env') === 'development') {
  config = env.dev;
} else {
  config = env.prod;
}

module.exports = config;
