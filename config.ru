require 'rack'
require 'rubygems'
require 'bundler/setup'
require 'grape'
require './app/api/messages'

run Messages
