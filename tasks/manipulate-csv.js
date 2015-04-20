var fs = require('fs');
var Path = require('path');

var Promise = require('bluebird');
var ps = require('promise-streams');
var csvParse = require('csv-parse');
var transform = require('stream-transform');
var csvStringify = require('csv-stringify');
var iconv = require('iconv-lite');

var defaultOptions = {
}

function shrink(option, record) {
  return record.filter(function(column, index) {
    return option.removeColumn.indexOf(index) < 0;
  })
}

function translate(option, record) {
  return record.map(function(key) {
    if (option.from.indexOf(key) >= 0) {
      return option.to[option.from.indexOf(key)];
    } else {
      return key;
    }
  });
}

function processFile(from, to, option) {
  var decoder = iconv.decodeStream('shift_jis');
  var encoder = iconv.encodeStream('utf8');
  var parser = csvParse({});
  var reader = fs.createReadStream(from);
  var transformer = transform(function(record) {
    row = shrink(option, record);

    if (!headerProcessed) {
      headerProcessed = true;
      return translate(option, row);
    } else {
      return row;
    }
  });
  var stringifier = csvStringify({quotedString: true});
  var writer = fs.createWriteStream(to, { encoding: 'utf8' });
  writer.on('finish', function() {
    console.log("processing of '" + Path.basename(from) + "' is complete.");
  });

  var headerProcessed = false;

  return ps.wait(reader.pipe(decoder).pipe(encoder).pipe(parser).pipe(transformer).pipe(stringifier).pipe(writer));
}

module.exports = function(grunt) {
  grunt.registerMultiTask('manipulate-csv', 'Manipulate CSV for reducing column and converting header.', function() {
    var options = this.options(defaultOptions);

    var files = this.files.map(function(f) {
      return processFile(f.src[0], f.dest, options[Path.basename(f.src[0], '.csv')]);
    });

    var done = this.async();

    Promise.all(files).then(function() {
      done();
    });
  });
}
