# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap
pin 'application', preload: true
pin '@hotwired/turbo-rails', to: 'turbo.min.js', preload: true
pin '@hotwired/stimulus', to: 'stimulus.min.js', preload: true
pin '@hotwired/stimulus-loading', to: 'stimulus-loading.js', preload: true
pin '@rails/actioncable', to: 'actioncable.esm.js'
pin_all_from 'app/javascript/controllers', under: 'controllers'
pin_all_from 'app/javascript/channels', under: 'channels'
pin 'bootstrap', to: 'bootstrap.min.js', preload: true
pin "consumer", to: "app/javascript/channels/consumer.js", preload: true
pin 'signaling_server', to: 'signaling_server.js'
pin "application", to: "application.js"
pin "typescript", to: "https://cdn.skypack.dev/typescript"
pin "hello", to: "hello.js"