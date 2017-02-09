var gulp = require('gulp');
var codeclimate = require('gulp-codeclimate-reporter');

gulp.task('codeclimate', function() {
  if (process.version.indexOf('v4') > -1) {
    gulp.src('coverage/lcov.info', { read: false })
      .pipe(codeclimate({
        token: '98c10ee52b1795a3b1d48df9ad4ad6a046a45af5ac9010bc146de7f56bcc503b'
      }));
  }
});

