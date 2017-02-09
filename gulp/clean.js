const gulp = require('gulp');
const rimraf = require('rimraf');

gulp.task('clean:coverage', cb => {
  rimraf('./coverage', cb);
});

gulp.task('clean:dist', (cb) => {
  rimraf('./dist', cb);
});

