var spawn = require('child_process').spawn;
var path = require('path');
var gulp = require('gulp');
var header = require('gulp-header');
var plumber = require('gulp-plumber');
var coffee = require('gulp-coffee');

var file = {
  bin: './src/@(bin)/**/*.coffee',
  coffee: ['./src/**/*.coffee', '!./src/bin/**/*.coffee']
};
dir = { dist: { root: './dist/' } }
gulp.task('clean', function(cb) {
  ch = spawn('rm', ['-rf', path.join(__dirname, dir.dist.root)]);
  ch.on('error', cb);
  ch.on('close', cb);
});
gulp.task('coffee', function() {
  return gulp.src(file.coffee)
    .pipe(plumber())
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest(dir.dist.root));
});
gulp.task('bin', function() {
  return gulp.src(file.bin)
    .pipe(plumber())
    .pipe(coffee({bare: true}))
    .pipe(header('#!/usr/bin/env node\n'))
    .pipe(gulp.dest(dir.dist.root));
});
gulp.task('watch', function() {
  gulp.watch(file.bin, ['bin']);
  gulp.watch(file.coffee, ['coffee']);
});
gulp.task('compile', ['coffee', 'bin']);
gulp.task('build', ['clean', 'compile']);
gulp.task('default', ['build', 'watch']);
gulp.task('publish', ['build']);


