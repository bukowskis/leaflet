require File.expand_path('../lib/leaflet/version', __FILE__)

Gem::Specification.new do |spec|

  spec.authors      = %w{ bukowskis }
  spec.summary      = "A very robust, custom, light-weight paginator."
  spec.description  = "A very robust, custom, light-weight paginator. Based on the leaf gem which is based on the will_paginate gem."
  spec.homepage     = 'https://github.com/bukowskis/leaflet'
  spec.license      = 'MIT'

  spec.name         = 'leaflet'
  spec.version      = Leaflet::VERSION::STRING

  spec.files        = Dir['{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
  spec.require_path = 'lib'

  spec.rdoc_options.concat ['--encoding',  'UTF-8']

  spec.add_development_dependency('rspec')
  spec.add_development_dependency('guard-rspec')
  spec.add_development_dependency('rb-fsevent')

end
