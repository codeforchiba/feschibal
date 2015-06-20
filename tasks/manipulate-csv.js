var fs = require('fs');
var Path = require('path');

var Promise = require('bluebird');
var ps = require('promise-streams');
var csvParse = require('csv-parse');
var _ = require('highland');
var transform = require('stream-transform');
var unique = require('unique-stream');
var pass = require('stream').PassThrough;
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
  if (option.from == null || option.to == null) {
    return record;
  } else {
    return record.map(function(key) {
      if (option.from.indexOf(key) >= 0) {
        return option.to[option.from.indexOf(key)];
      } else {
        return key;
      }
    });
  }
}

function processFile(g, from, to, option) {
  g.file.mkdir(Path.dirname(to));

  var decoder = iconv.decodeStream(option.encoding);
  var encoder = iconv.encodeStream('utf8');
  var parser = csvParse({});
  var reader = fs.createReadStream(from);
  var filter = _.pipeline(_.filter(function(record) {
    if (option.filter == null) {
      return true;
    } else {
      if (!filterHeaderProcessed) {
        filterHeaderProcessed = true;
        return true;
      } else {
        return record.every(function(column, index) {
          f = option.filter[index.toString()];

          if (f) {
            if (typeof f === 'function') {
              return f(column);
            } else {
              return column.match(new RegExp(f));
            }
          } else {
            return true;
          }
        });
      }
    }
  }));
  var transformer = transform(function(record) {
    var row = shrink(option, record);

    if (!transformerHeaderProcessed) {
      transformerHeaderProcessed = true;
      return translate(option, row);
    } else {
      return row;
    }
  });
  var uniquerer = option.unique ? unique() : pass({ objectMode: true });
  var stringifier = csvStringify({quotedString: true});
  var writer = fs.createWriteStream(to, { encoding: 'utf8' });
  writer.on('finish', function() {
    console.log("processing of '" + Path.basename(from) + "' is complete.");
  });

  var filterHeaderProcessed = false;
  var transformerHeaderProcessed = false;

  return ps.wait(reader.pipe(decoder).pipe(encoder).pipe(parser).pipe(filter).pipe(transformer).pipe(uniquerer).pipe(stringifier).pipe(writer));
}

module.exports = function(grunt) {
  grunt.registerMultiTask('manipulate-csv', 'Manipulate CSV for reducing column and converting header.', function() {
    var options = this.options(defaultOptions);

    var files = this.files.map(function(f) {
      return processFile(grunt, f.src[0], f.dest, options[Path.basename(f.src[0], '.csv')]);
    });

    var done = this.async();

    Promise.all(files).then(function() {
      done();
    });
  });
}
