module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json'),

    watch:
      compass:
        files: ['**/*.sass']
        tasks: ['compass:dev']
      jade:
        files: ['**/*.jade']
        tasks: ['jade:compile']
      copy:
        files: ['bower.json', 'assets/images/**.*']
        task:  ['copy:main']

    compass:
      dev:
        options:         
          sassDir: ['assets/stylesheets']
          cssDir: ['build/stylesheets']
          environment: 'development'

    jade: 
      compile:
        files: grunt.file.expandMapping ['**/*.jade', '!**/_*.jade'], 'build/'
          cwd: 'views'
          rename: (destBase, destPath) ->
            return destBase + destPath.replace /\.jade$/, '.html'

    connect:
      server:
        options:
          port: 8000,
          base: 'build'

    copy: 
      main: 
        files: [
          { expand: true, cwd: 'bower_components', src: ['**'], dest: 'build/vendors' }
          { expand: true, cwd: 'assets/images', src: ['**'], dest: 'build/images' }
        ]

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-jade'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'default', ['compass:dev', 'jade:compile', 'copy:main', 'connect', 'watch']

