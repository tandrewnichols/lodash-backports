const gulp = require('gulp');
const codeclimate = require('gulp-codeclimate-reporter');

gulp.task('codeclimate', () => {
  if (process.version.indexOf('v4') > -1) {
    gulp.src('coverage/lcov.info', { read: false })
      .pipe(codeclimate({
        token: 'f151f3ae0064c9a1137a2393c89344e3b15910c3bf2029d26444b578fb667051'
      }));
  }
});

