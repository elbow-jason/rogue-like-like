# Include gulp
gulp = require("gulp")

# Include Our Plugins
jshint    = require("gulp-jshint")
sass      = require("gulp-sass")
concat    = require("gulp-concat")
uglify    = require("gulp-uglify")
rename    = require("gulp-rename")

# Lint Task
gulp.task "lint", ->
  gulp.src("src/*.js")
    .pipe(jshint())
    .pipe jshint.reporter("default")


###
# Compile Our Sass
gulp.task "sass", ->
  gulp.src("scss/*.scss")
    .pipe(sass())
    .pipe gulp.dest("css")
###

# Concatenate & Minify JS
gulp.task "scripts", ->
  gulp.src(["src/*.js", "src/services/*.js", "src/controllers/*.js"])
    .pipe(concat("rogue-like-like.js"))
    .pipe(gulp.dest("dist"))
    .pipe(rename("rogue-like-like.min.js"))
    .pipe(uglify()).pipe gulp.dest("dist")


# Watch Files For Changes
gulp.task "watch", ->
  gulp.watch "src/*.js", [
    "lint"
    "scripts"
  ]
  #gulp.watch "scss/*.scss", ["sass"]
  return


# Default Task
gulp.task "default", [
  "lint"
  #"sass"
  "scripts"
  "watch"
]
