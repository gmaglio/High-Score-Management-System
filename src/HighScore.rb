#!/usr/bin/env ruby

class HighScore

     attr_accessor :name 
     attr_accessor :score 
     attr_accessor :date

     def initialize
          @name = Gtk::Entry.new
          @score = Gtk::Entry.new
          @date = Gtk::Entry.new
     end

end
