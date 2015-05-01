# Dependencies
################################################################################
gulp           = require 'gulp'
es             = require 'event-stream'
nodemon        = require 'gulp-nodemon'
coffee         = require 'gulp-coffee'
annotate       = require 'gulp-ng-annotate'
concat         = require 'gulp-concat'
uglify         = require 'gulp-uglify'
htmlmin        = require 'gulp-htmlmin'
include        = require 'gulp-include'
sass           = require 'gulp-sass'
minifyCSS      = require 'gulp-minify-css'
del            = require 'del'
templates      = require 'gulp-ng-templates'
sourcemaps     = require 'gulp-sourcemaps'

# Tasks
################################################################################
gulp.task 'clean', (cb) ->
  del.sync('./public')
  cb() # Callback, so only continue if called

gulp.task 'server', () ->
  nodemon(
    script: 'server.coffee'
    ext: 'coffee'
    env:
      'NODE_ENV': 'development'
  )

gulp.task 'js', ['js:app', 'js:vendors']

gulp.task 'js:app', () ->
  es.concat(
      gulp.src(['app/scripts/*.coffee', '!app/scripts/vendors.js', 'app/modules/**/*.coffee'])
        .pipe(sourcemaps.init())
        .pipe(coffee({bare: true}))
        .pipe(annotate()), # Safe angular injection
      gulp.src('app/modules/**/*.html')
        .pipe(sourcemaps.init())
        .pipe(templates(
          standalone: false
          module: 'mean'
        ))
    ).pipe(concat('app.js'))
    .pipe(uglify())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./public/scripts'))

gulp.task 'js:vendors', () ->
  gulp.src('app/scripts/vendors.js', base: 'app')
    .pipe(sourcemaps.init())
    .pipe(include())
    .pipe(uglify())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./public'))

gulp.task 'css', ['css:app', 'css:vendors']

gulp.task 'css:app', () ->
  gulp.src(['app/styles/app.scss', 'app/modules/**/*.scss'])
    .pipe(sourcemaps.init())
    .pipe(sass({includePaths: ['app']}))
    .pipe(concat('app.css'))
    .pipe(minifyCSS())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./public/styles'))

gulp.task 'css:vendors', () ->
  gulp.src('app/styles/vendors.scss', base: 'app')
    .pipe(sourcemaps.init())
    .pipe(sass({includePaths: ['app']}))
    .pipe(minifyCSS())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('./public'))


gulp.task 'html', () ->
  gulp.src('app/index.html', base: 'app')
    .pipe(htmlmin
      collapseWhitespace: true
      removeComments: true
    )
    .pipe(gulp.dest('./public'))

gulp.task 'fonts', () ->
  gulp.src([
    'bower_components/fontawesome/fonts/*'
    'bower_components/bootstrap-sass-official/fonts/*'
  ])
  .pipe(gulp.dest('./public/fonts/'))

gulp.task 'build', [
  'clean'
  'fonts'
  'js'
  'css'
  'html'
]

# global watcher task to do all the magical stuff
gulp.task 'watch', ['build'], () ->
  gulp.start.apply(gulp, ['server']);
  gulp.watch(['app/scripts/*.coffee', '!app/scripts/vendors.js', 'app/modules/**/*'], ['js:app'])
  gulp.watch(['app/scripts/vendors.js'], ['js:vendors'])
  gulp.watch(['app/index.html'], ['html'])
  gulp.watch(['app/styles/app.scss', 'app/modules/**/*.scss'], ['css:app'])
  gulp.watch(['app/styles/vendors.scss'], ['css:vendors'])

gulp.task 'default', ['watch']
