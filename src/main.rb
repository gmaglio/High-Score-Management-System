#!/usr/bin/env ruby

# Author: Gregory Maglio
# main.rb: main executable and tie-in of hsms.

require 'rubygems'
require 'gtk2'
require 'HighScore'
require 'DBHandler'
require 'ScoreLister'
require 'ScoreInserter'
require 'MenuBar'

window = Gtk::Window.new(Gtk::Window::TOPLEVEL)
window.resizable = true
window.title = "List Window"
window.border_width = 0
window.signal_connect('delete_event') { Gtk.main_quit }
window.set_size_request(250, 175)

# push the array to the Lister Entity
hsArray = Array.new { HighScore.new }
theDB = DBHandler.new
theDB.get_records.each do |x, y, z| hsArray.push(HighScore.new(x, y, z)) end
myLister = ScoreLister.new(hsArray)

myMenu = MenuBar.new(myLister)

vbox = Gtk::VBox.new(false, 0)

# pack main window with menu and lister
vbox.pack_start(myMenu.menubar, false)
vbox.pack_start(myLister.scrolled_win)
window.add_accel_group(myMenu.group)
window.add(vbox)

window.show_all
Gtk.main
