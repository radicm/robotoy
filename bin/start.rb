#!/usr/bin/env ruby

# TODO load path should be handled in a better way with ruby -Idirectory or -Cdirectory
# TODO but I didn't had enough time to make it work

dir = File.expand_path(File.dirname(__FILE__))
dir.gsub!('bin', 'lib')
$LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)

require '../lib/robotoy'

Robotoy.start_game
