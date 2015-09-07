var fs = require('fs');
var Path = require('path');

var Promise = require('bluebird');
var ps = require('promise-streams');
var oboe = require('oboe');
var moment = require('moment');

var defaultOptions = {
}

function processDateRange(date, startTime, endTime) {
  dateObj = {};

  if (startTime.length > 0) {
    dateObj.start = moment(date + " " + startTime, "YYYY/MM/DD HH:mm");
  } else {
    dateObj.start = moment(date, "YYYY/MM/DD");
  }

  if (endTime.length > 0) {
    dateObj.end = moment(date + " " + endTime, "YYYY/MM/DD HH:mm");
  }

  return dateObj;
}

function convertJson(data, writer) {
  oboe(data)
    .node('!.*', function(obj) {
      info = {
        id: obj.id,
        name: obj.name,
        location: {
          name: obj.location_name,
          state: "千葉県",
          stateCode: "12",
          city: "千葉市",
          cityCode: "1212",
          address: obj.location_address.slice(3),
          addressCode: obj.location_code,
          lat: obj.location_lat,
          long: obj.location_long
        },
        features: {
          dancing: obj.features_dancing === "1",
          singing: obj.features_singing === "1",
          drum: obj.features_drum === "1",
          musicalPerformance: obj.features_musicalPerformance === "1",
          foodTruck: obj.features_foodTruck === "1",
          fireworks: obj.features_fireworks === "1",
        },
        organizer: obj.organizer
      };

      info.periods = []
      if (obj.date1.length > 0) {
        info.periods.push(processDateRange(obj.date1, obj.startTime1, obj.endTime1));
      }

      if (obj.date2.length > 0) {
        info.periods.push(processDateRange(obj.date2, obj.startTime2, obj.endTime2));
      }

      if (obj.date3.length > 0) {
        info.periods.push(processDateRange(obj.date3, obj.startTime3, obj.endTime3));
      }

      if (obj.features_others.length > 0) {
        info.features.others = [obj.features_others]
      }

      if (obj.specialProgram1.length > 0) {
        info.features.specialProgram = [obj.specialProgram1];

        if (obj.specialProgram2.length > 0) {
          info.features.specialProgram.push(obj.specialProgram2);
        }
      }

      if (obj.remarks.length > 0) {
        info.remarks = obj.remarks;
      }

      if (obj.url.length > 0) {
        info.url = obj.url;
      }

      if (obj.sponcer1.length > 0) {
        info.sponcers = [obj.sponcer1];

        if (obj.sponcer2.length > 0) {
          info.sponcers.push(obj.sponcer2);
        }
      }

      return info;
    })
    .fail(function(errors) {
      console.log(errors.thrown);
    })
    .done(function(objects) {
      writer.end(JSON.stringify(objects, null, "  "));
    });
}

function processFile(g, from, to) {
  g.file.mkdir(Path.dirname(to));

  var reader = fs.createReadStream(from);
  var writer = fs.createWriteStream(to, { encoding: 'utf8' });

  convertJson(reader, writer);
  writer.on('finish', function() {
    console.log("processing of '" + Path.basename(from) + "' is complete.");

  });

  return ps.wait(writer);
}

module.exports = function(grunt) {
  grunt.registerMultiTask('map-json', 'Map flat json to structured json.', function() {
    var options = this.options(defaultOptions);

    files = this.files.map(function(f) {
      if (!!options[Path.basename(f.src[0], '.json')]) {
        return processFile(grunt, f.src[0], f.dest);
      }
    });

    var done = this.async();

    Promise.all(files).then(function() {
      done();
    });
  });
}
