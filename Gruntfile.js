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
        files: ['<%= config.app %>/scripts/{,*/}*.js'],
        tasks: ['replace:dev', 'jshint'],
        options: {
          livereload: true
        }
      },
      riot: {
        files: ['<%= config.app %>/scripts/{,*/}*.tag'],
        tasks: ['riot']
      },
      gruntfile: {
        files: ['Gruntfile.js']
      },
      sass: {
        files: ['<%= config.app %>/styles/{,*/}*.{scss,sass}'],
        tasks: ['sass:server', 'autoprefixer']
      },
      styles: {
        files: ['<%= config.app %>/styles/{,*/}*.css'],
        tasks: ['newer:copy:styles', 'autoprefixer']
      },
      livereload: {
        options: {
          livereload: '<%= connect.options.livereload %>'
        },
        files: [
          '<%= config.app %>/{,*/}*.html',
          '.tmp/styles/{,*/}*.css',
          '<%= config.app %>/images/{,*/}*',
          '.tmp/scripts/{,*/}*.js'
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
            return [
              connect.static('.tmp'),
              connect.static(config.app)
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
            [/(images\/.*?\.(?:gif|jpeg|jpg|png|webp))/gm, 'Update the JS to reference our revved images']
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
          src: '{,*/}*.{gif,jpeg,jpg,png}',
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
        files: [{
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
        }, {
          src: 'deploy/gh-pages/circle.yml',
          dest: '<%= config.dist %>/circle.yml'
        }]
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

    'gh-pages': {
      options: {
        base: 'dist'
      },
      src: '**/*'
    },

    'manipulate-csv': {
      options: {
        kouen_1: {
          encoding: 'shift_jis',
          unique: true,
          removeColumn: [ 2, 3, 4, 9, 10, 14, 15, 16, 17, 18, 19, 20, 21, 22, 24, 25, 26, 27, 28, 29],
          from: ['施設、場所、イベントの名称', '施設、場所、イベントの名称（読み）', '経度（世界測地系）', '緯度（世界測地系）', '郵便番号', '住所', '電話番号', 'FAX番号', 'アクセス', 'ホームページURL（PC）'],
          to: ['name', 'kanaName', 'longitude', 'latitude', 'postalCode', 'address', 'phone', 'fax', 'directions', 'url']
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

    convert: {
      options: {
        explicitArray: false,
      },
      csv2json: {
        expand: true,
        cwd: '<%= config.data %>/csv/processed/',
        src: '*.csv',
        filter: 'isFile',
        dest: '<%= config.data %>/json/',
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
    }
  });

  grunt.registerTask('serve', 'start the server and preview your app, --allow-remote for remote access', function (target) {
    if (grunt.option('allow-remote')) {
      grunt.config.set('connect.options.hostname', '0.0.0.0');
    }
    if (target === 'dist') {
      return grunt.task.run(['build', 'connect:dist:keepalive']);
    }

    grunt.task.run([
      'clean:server',
      'concurrent:server',
      'replace:dev',
      'autoprefixer',
      'connect:livereload',
      'watch'
    ]);
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
    'htmlmin',
    'gh-pages'
  ]);

  grunt.registerTask('default', [
    'newer:jshint',
    'build'
  ]);
};
