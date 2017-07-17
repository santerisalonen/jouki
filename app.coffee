axis         = require 'axis'
# set up contentful config as environment variables (in dev)
try 
  env = require './env' 
  process.env.access_token = env.access_token
  process.env.space_id = env.space_id
catch err

rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
contentful   = require 'roots-contentful'
slugify = require 'slug'
slugify.defaults.modes['pretty']['lower'] = true 

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'env.coffee', 'ship.*conf']

  extensions: [
    contentful
      access_token: process.env.access_token
      space_id: process.env.space_id
      content_types:
        pages:
          id: 'page'
          template: 'views/page.hbs'
          path: (e) -> "#{slugify(e.name)}"     
        posts:
          id: 'post'
          template: 'views/post.hbs'
          path: (e) -> "posts/#{slugify(e.headline)}"
          
    js_pipeline(files: [ "assets/js/jquery-3.2.1.js", "assets/js/*.js"], out: 'js/build.js', minify: true)
    css_pipeline(files: "assets/css/**", out: 'css/build.css', minify: true)
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true
