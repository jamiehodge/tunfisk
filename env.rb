require 'bundler/setup'
Bundler.require :default, ENV['RACK_ENV'].to_sym

require_relative 'config/sequel'

require_relative 'lib/models'