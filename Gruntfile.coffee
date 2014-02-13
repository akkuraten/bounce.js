config =
  watch:
    browserify:
      files: [
        "app/scripts/**/*.coffee"
        "app/templates/**/*.hbs"
      ]
      tasks: ["browserify"]

    livereload:
      options:
        livereload: "<%= connect.options.livereload %>"

      files: [
        ".tmp/**/*"
        "app/index.html"
      ]

  browserify:
    options:
      debug: true
      transform: ["coffeeify", "hbsfy"]
      extensions: [".js", ".coffee", ".hbs"]
      shim:
        prefixfree:
          path: "bower_components/prefixfree/prefixfree.min.js"
          exports: "PrefixFree"

      alias: [
        "bower_components/jquery/jquery.js:jquery"
        "bower_components/backbone/backbone.js:backbone"
        "bower_components/prefixfree/prefixfree.min.js:prefixfree"
        "app/scripts/lib/bounce/index.coffee:bounce"
      ]
      aliasMappings: [
        cwd: "app/"
        src: ["**/*.coffee", "**/*.js", "**/*.hbs"]
        dest: ""
      ]

    all:
      files:
        ".tmp/scripts/app.js": [
          "app/scripts/**/*.coffee"
          "app/templates/**/*.hbs"
        ]

    test:
      files:
        ".tmp/scripts/tests.js": [
          "app/scripts/lib/bounce/index.coffee"
          "test/**/*.coffee"
        ]

  connect:
    options:
      port: 9000
      livereload: 35730
      hostname: "0.0.0.0"

    livereload:
      options:
        base: [
          ".tmp"
          "app/"
        ]

    test:
      options:
        port: 9001
        base: [
          ".tmp"
          "app"
          "test"
          "node_modules"
        ]

  mocha:
    all:
      options:
        run: true
        bail: false
        log: true
        reporter: "Spec"
        urls: ["http://localhost:9001/test.html"]


module.exports = (grunt) ->
  require("time-grunt") grunt
  require("load-grunt-tasks") grunt

  grunt.initConfig config

  grunt.registerTask "serve", [
    "browserify:all"
    "connect:livereload"
    "watch"
  ]

  grunt.registerTask "test", [
    "browserify:test"
    "connect:test"
    "mocha"
  ]

  grunt.registerTask "watch:test", ->
    config =
      test:
        files: ["app/scripts/**/*.coffee", "test/**/*.coffee"]
        tasks: "test"

    grunt.config "watch", config
    grunt.task.run "watch"
