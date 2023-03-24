// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
// import "./controllers"
import $ from 'jquery'

import './components'

globalThis.X_CSRF_Token = $('meta[name="csrf-token"]').attr('content')