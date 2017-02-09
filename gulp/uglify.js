var gulp = require('gulp');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var config = require('./config');

gulp.task('uglify', function() {
  gulp.src(config.lib)
    .pipe(uglify())
    .pipe(rename('lodash-aliases.min.js'))
    .pipe(gulp.dest('dist'));
});
