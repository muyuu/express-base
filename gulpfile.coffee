g = require "gulp"
$ = require('gulp-load-plugins')()
gulpFilter = require 'gulp-filter'
mainBowerFiles = require 'main-bower-files'
runSequence = require 'run-sequence'
del = require 'del'

src = "src/"
dist = "public/"
asset = "assets/"
spec = "spec/"
txt = "txt/"

s =
  root: src
  css: src + "css/"
  js: src + "js/"

d =
  root: dist
  html: dist
  css: dist + asset + "css/"
  js: dist + asset + "js/"
  lib: dist + asset + "libs/"
  img: dist + asset + "img/"

t =
  root: spec
  coffee: spec + "js/"
  fixture: spec + "fixtures/"


jsFiles = [
  "#{d.js}util/extend.js"
  "#{d.js}util/polyfill.js"
  "#{d.js}util/validate.js"
  "#{d.js}init.js"
  "#{d.js}controller/**/*.js"
  "#{d.js}model/**/*.js"
  "#{d.js}view/**/*.js"
  "#{d.js}run.js"
]

# bower
g.task 'clear-libs', ->
  del.sync "#{d.lib}"

g.task "bower", ['clear-libs'], ->
  jsFilter = gulpFilter "**/*.js"
  cssFilter = gulpFilter "**/*.css"

  g.src(mainBowerFiles())
    .pipe(jsFilter)
    .pipe(g.dest("#{d.lib}"))
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe(g.dest("#{d.lib}css"))


# css
g.task "css", ->
  g.src "#{s.css}style.styl"
    .pipe $.plumber()
    .pipe $.stylus()
    .pipe g.dest("#{d.css}")

# js
g.task "js", ->
  g.src "#{s.js}**/*.coffee"
  .pipe $.coffee
    bare: true
  .pipe g.dest("#{d.js}")

# concatJS
g.task "concatJS", ->
  g.src jsFiles
  .pipe $.concat 'app.js'
  .pipe g.dest "#{d.js}"

# kss
g.task 'kss', ->
  g.src "#{d.css}style.css"
    .pipe g.dest "#{dist}guides/public"

  g.src "#{d.css}style.css"
    .pipe $.kss
      overview: "#{dist}guides/styleguide.md"
      templateDirectory: "#{dist}guides/template"
    .pipe g.dest("#{dist}guides")

# watch
g.task "watch", ->
  g.watch "#{s.css}**/*.styl", ["css"]
  g.watch "#{s.js}**/*.coffee", ["js"]
  g.watch "#{d.js}**/*.js", ["concatJS"]



# 開発時に使うタスク
g.task "default", ->
  g.start "watch"


# 最初に使うタスク
g.task "lib", ->
  g.start "bower"


# デプロイ時に使うタスク
g.task "release", (callback)->
  # 各タスクを直列に実行
  runSequence('usemin', 'clean', callback)


# スタイルガイドを生成するタスク
g.task "guide", (callback)->
  runSequence("kss", callback)

