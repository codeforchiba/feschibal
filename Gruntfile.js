// Generated on 2015-03-10 using
// generator-webapp 0.5.1
'use strict';

module.exports = function (grunt) {

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  //
  grunt.loadTasks('tasks');

  // Configurable paths
  var config = {
    app: 'app',
    dist: 'dist',
    data: 'data'
  };

  // load env file
  var yaml = require("js-yaml");
  var fs = require("fs");
  var env = yaml.load(fs.readFileSync("env.yml"));

  // Define the configuration for all the tasks
  grunt.initConfig({

    // Project settings
    config: config,

    // Watches files for changes and runs tasks based on the changed files
    watch: {
      js: {
        files: ['<%= config.app %>/scripts/**/*.js'],
        tasks: ['replace:dev', 'jshint'],
        options: {
          livereload: true
        }
      },
      riot: {
        files: ['<%= config.app %>/scripts/**/*.tag'],
        tasks: ['riot']
      },
      gruntfile: {
        files: ['Gruntfile.js']
      },
      sass: {
        files: ['<%= config.app %>/styles/**/*.{scss,sass}'],
        tasks: ['sass:server', 'autoprefixer']
      },
      styles: {
        files: ['<%= config.app %>/styles/**/*.css'],
        tasks: ['newer:copy:styles', 'autoprefixer']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '<%= config.app %>/**/*.html',
          '.tmp/styles/**/*.css',
          '<%= config.app %>/images/**/*',
          '.tmp/scripts/**/*.js'
        ]
      }
    },

    // The actual grunt server settings
    connect: {
      options: {
        port: 9000,
        open: true,
        livereload: 35729,
        // Change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      },
      livereload: {
        options: {
          middleware: function(connect) {
            var serveStatic = require('serve-static');
            return [
              serveStatic('.tmp'),
              serveStatic(config.app)
            ];
          }
        }
      },
      dist: {
        options: {
          base: '<%= config.dist %>',
          livereload: false
        }
      }
    },

    // Empties folders to start fresh
    clean: {
      dist: {
        files: [{
          dot: true,
          src: [
            '.tmp',
            '<%= config.dist %>/*',
            '!<%= config.dist %>/.git*'
          ]
        }]
      },
      server: '.tmp'
    },

    // Make sure code styles are up to par and there are no obvious mistakes
    jshint: {
      options: {
        jshintrc: '.jshintrc',
        reporter: require('jshint-stylish')
      },
      all: [
        '<%= config.app %>/scripts/{,*/}*.js',
        '!<%= config.app %>/scripts/vendor/*'
      ]
    },

    // Compiles Sass to CSS and generates necessary files if requested
    sass: {
      options: {
        sourceMap: true
        },
      dist: {
        files: [{
          expand: true,
          cwd: '<%= config.app %>/styles',
          src: ['app.scss'],
          dest: '.tmp/styles',
          ext: '.css'
        }]
      },
      server: {
        files: [{
          expand: true,
          cwd: '<%= config.app %>/styles',
          src: ['app.scss'],
          dest: '.tmp/styles',
          ext: '.css'
        }]
      }
    },

    // Add vendor prefixed styles
    autoprefixer: {
      options: {
        browsers: ['> 1%', 'last 2 versions', 'Firefox ESR', 'Opera 12.1']
      },
      dist: {
        files: [{
          expand: true,
          cwd: '.tmp/styles/',
          src: '{,*/}*.css',
          dest: '.tmp/styles/'
        }]
      }
    },

    // Renames files for browser caching purposes
    rev: {
      dist: {
        files: {
          src: [
            '<%= config.dist %>/scripts/{,*/}*.js',
            '<%= config.dist %>/styles/{,*/}*.css',
            '<%= config.dist %>/images/{,*/}*.*',
            '<%= config.dist %>/styles/fonts/{,*/}*.*',
            '<%= config.dist %>/*.{ico,png}'
          ]
        }
      }
    },

    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      options: {
        dest: '<%= config.dist %>'
      },
      html: '<%= config.app %>/index.html'
    },

    // Performs rewrites based on rev and the useminPrepare configuration
    usemin: {
      options: {
        assetsDirs: [
          '<%= config.dist %>',
          '<%= config.dist %>/images',
          '<%= config.dist %>/styles'
        ],
        patterns: {
          js: [
            [/(images\/.*?\.(?:gif|jpeg|jpg|png|webp|svg))/gm, 'Update the JS to reference our revved images']
          ]
        }
      },
      html: ['<%= config.dist %>/{,*/}*.html'],
      css: ['<%= config.dist %>/styles/{,*/}*.css'],
      js: '<%= config.dist %>/scripts/*.js'
    },

    // The following *-min tasks produce minified files in the dist folder
    imagemin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= config.app %>/images',
          src: '{,**/}*.{gif,jpeg,jpg,png}',
          dest: '<%= config.dist %>/images'
        }]
      }
    },

    svgmin: {
      dist: {
        files: [{
          expand: true,
          cwd: '<%= config.app %>/images',
          src: '{,*/}*.svg',
          dest: '<%= config.dist %>/images'
        }]
      }
    },

    htmlmin: {
      dist: {
        options: {
          collapseBooleanAttributes: true,
          collapseWhitespace: true,
          conservativeCollapse: true,
          removeAttributeQuotes: true,
          removeCommentsFromCDATA: true,
          removeEmptyAttributes: true,
          removeOptionalTags: true,
          removeRedundantAttributes: true,
          useShortDoctype: true
        },
        files: [{
          expand: true,
          cwd: '<%= config.dist %>',
          src: '{,*/}*.html',
          dest: '<%= config.dist %>'
        }]
      }
    },

    // By default, your `index.html`'s <!-- Usemin block --> will take care
    // of minification. These next options are pre-configured if you do not
    // wish to use the Usemin blocks.
    // cssmin: {
    //   dist: {
    //     files: {
    //       '<%= config.dist %>/styles/main.css': [
    //         '.tmp/styles/{,*/}*.css',
    //         '<%= config.app %>/styles/{,*/}*.css'
    //       ]
    //     }
    //   }
    // },
    // uglify: {
    //   dist: {
    //     files: {
    //       '<%= config.dist %>/scripts/scripts.js': [
    //         '<%= config.dist %>/scripts/scripts.js'
    //       ]
    //     }
    //   }
    // },
    // concat: {
    //   dist: {}
    // },

    // Copies remaining files to places other tasks can use
    copy: {
      dist: {
        files: [
          {
            expand: true,
            dot: true,
            cwd: '<%= config.app %>',
            dest: '<%= config.dist %>',
            src: [
              '*.{ico,png,txt}',
              'images/{,*/}*.webp',
              '{,*/}*.html',
              'styles/fonts/{,*/}*.*',
              'data/{,*/}*.*'
            ]
          }, {
            src: 'node_modules/apache-server-configs/dist/.htaccess',
            dest: '<%= config.dist %>/.htaccess'
          }
        ]
      },
      styles: {
        expand: true,
        dot: true,
        cwd: '<%= config.app %>/styles',
        dest: '.tmp/styles/',
        src: '{,*/}*.css'
      }
    },

    // Run some tasks in parallel to speed up build process
    concurrent: {
      server: [
        'sass:server',
        'copy:styles',
        'riot'
      ],
      dist: [
        'sass',
        'copy:styles',
        'imagemin',
        'svgmin',
        'riot'
      ]
    },

    riot: {
      options:{
      },
      dist: {
        expand: true,
        cwd: '<%= config.app %>/scripts',
        src: '**/*.tag',
        dest: '.tmp/scripts',
        ext: '.js'
      }
    },

    'manipulate-csv': {
      options: {
        '12chiba': {
          encoding: 'shift_jis',
          filter: {
            5: "0",
            6: "0",
            9: "千葉市"
          },
          unique: true,
          removeColumn: [ 0, 4, 5, 6, 8, 10, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21],
          from: ['都道府県CD', '市区町村CD', '町域CD', '都道府県', '市区町村', '町域'],
          to: ['stateCode', 'cityCode', 'addressCode', 'state', 'city', 'address']
        },
        kouen_1: {
          encoding: 'shift_jis',
          filter: {
            0: "稲毛"
          },
          unique: true,
          removeColumn: [ 2, 3, 4, 9, 10, 14, 15, 16, 17, 18, 19, 20, 21, 22, 24, 25, 26, 27, 28, 29],
          from: [
            '施設、場所、イベントの名称', '施設、場所、イベントの名称（読み）', '経度（世界測地系）', '緯度（世界測地系）',
            '郵便番号', '住所', '電話番号', 'FAX番号', 'アクセス', 'ホームページURL（PC）'
          ],
          to: [
            'name', 'kanaName', 'longitude', 'latitude',
            'postalCode', 'address', 'phone', 'fax', 'directions', 'url'
          ]
        },
        chiba_festival: {
          encoding: 'shift_jis',
          removeColumn: [ 1, 3, 32, 38, 46, 49, 50, 51, 52, 57, 58],
          from: [
            'No', '祭りの名称', '開催日1', '開始時間1', '終了時間1', '開催日2', '開始時間2', '終了時間2',
            '開催日3', '開始時間3', '終了時間3', '開催日4', '開始時間4', '終了時間4',
            '開催日5', '開始時間5', '終了時間5', '開催日6', '開始時間6', '終了時間6',
            '開催日7', '開始時間7', '終了時間7', '開催日8', '開始時間8', '終了時間8',
            '開催日9', '開始時間9', '終了時間9', '備考', '会場名称',
            '会場住所', '会場住所コード', '会場緯度', '会場経度',
            '<踊り>', '<歌唱>', '<太鼓>', '<演奏>', '<出店・屋台>', '<花火>', '<その他>',
            '目玉イベント1', '目玉イベント2', '主催団体1', '主催団体2', '主催団体3'
          ],
          to: [
            'id', 'name', 'date1', 'startTime1', 'endTime1', 'date2', 'startTime2', 'endTime2',
            'date3', 'startTime3', 'endTime3', 'date4', 'startTime4', 'endTime4',
            'date5', 'startTime5', 'endTime5', 'date6', 'startTime6', 'endTime6',
            'date7', 'startTime7', 'endTime7', 'date8', 'startTime8', 'endTime8',
            'date9', 'startTime9', 'endTime9', 'remarks', 'location_name',
            'location_address', 'location_code', 'location_lat', 'location_long',
            'features_dancing', 'features_singing', 'features_drum', 'features_musicalPerformance',
            'features_foodTruck', 'features_fireworks', 'features_others',
            'specialProgram1', 'specialProgram2', 'organizer', 'sponsor1', 'sponsor2'
          ]
        }
      },
      files: {
        expand: true,
        cwd: '<%= config.data %>/csv/original/',
        src: '*.csv',
        filter: 'isFile',
        dest: '<%= config.data %>/csv/processed',
        ext: '.csv'
      }
    },

    'map-json': {
      options: {
        chiba_festival: true
      },
      files: {
        expand: true,
        cwd: '<%= config.data %>/json/generated/',
        src: '*.json',
        filter: 'isFile',
        dest: '<%= config.data %>/json/mapped',
        ext: '.json'
      }
    },

    convert: {
      options: {
        explicitArray: false,
      },
      csv2json: {
        expand: true,
        cwd: '<%= config.data %>/csv/processed/',
        src: '*.csv',
        filter: 'isFile',
        dest: '<%= config.data %>/json/generated/',
        ext: '.json'
      }
    },

    replace: {
      dev: {
        options: {
          patterns: [
            {
              json: env.dev
            }
          ]
        },
        files: [
          {
            expand: true,
            flatten: false,
            src: ['.tmp/scripts/**/*.js'],
            dest: '.'
          },
          {
            expand: true,
            flatten: false,
            cwd: '<%= config.app %>/scripts',
            src: ['**/*.js', '!vendor/**/*.*'],
            dest: '.tmp/scripts'
          }
        ]
      },
      prod: {
        options: {
          patterns: [
            {
              json: env.prod
            }
          ]
        },
        files: [
          {
            expand: true,
            flatten: false,
            src: ['.tmp/scripts/**/*.js'],
            dest: '.'
          },
          {
            expand: true,
            flatten: false,
            cwd: '<%= config.app %>/scripts',
            src: ['**/*.js', '!vendor/**/*.*'],
            dest: '.tmp/scripts'
          }
        ]
      }
    },

    express: {
      options: {
        script: 'bin/www'
      },
      dev: {
        options: {
          background: true,
          delay: 1,
          port: 9000
        }
      },
      prod: {
        options: {
          background: false,
          node_env: 'production'
        }
      }
    }
  });

  grunt.registerTask('serve', 'start the server and preview your app, --allow-remote for remote access', function (target) {
    if (grunt.option('allow-remote')) {
      grunt.config.set('connect.options.hostname', '0.0.0.0');
    }
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    var tasks = [
      'clean:server',
      'concurrent:server',
      'replace:dev',
      'autoprefixer'
    ];

    if (target === 'express') {
      tasks.push("express:dev");
    } else {
      tasks.push("connect:livereload");
    }

    tasks.push("watch");
    grunt.task.run(tasks);
  });

  grunt.registerTask('build', [
    'clean:dist',
    'useminPrepare',
    'concurrent:dist',
    'replace:prod',
    'autoprefixer',
    'concat',
    'cssmin',
    'uglify',
    'copy:dist',
    'rev',
    'usemin',
    'htmlmin'
  ]);

  grunt.registerTask('build-data', [
    'manipulate-csv',
    'convert',
    'map-json'
  ]);

  grunt.registerTask('default', [
    'newer:jshint',
    'build'
  ]);
};
