#!/usr/bin/env ruby

dir = File.expand_path("../lib", __FILE__)
dir = dir.gsub('/bin/lib', '/lib')
$LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)

require 'robotoy'

Robotoy.start_game
