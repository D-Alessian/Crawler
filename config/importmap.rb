# Pin npm packages by running ./bin/importmap

pin 'application'
pin '@hotwired/turbo-rails', to: 'turbo.min.js'
pin '@hotwired/stimulus', to: 'stimulus.min.js'
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin "jquery" # @3.7.1
pin "cocoon" # @0.1.1
pin "bootstrap" # @5.3.7
pin "@popperjs/core", to: "@popperjs--core.js" # @2.11.8
pin "cocoon-js" # @0.0.5
