#!/usr/bin/env ruby

<<<<<<< HEAD
# Author: Gregory Maglio
# HighScore.rb: Object to define HighScore as a data structure.

=======
>>>>>>> 203a634da23cb022cd4c298844e902eecdd9d384
class HighScore

     attr_accessor :name 
     attr_accessor :score 
     attr_accessor :date

<<<<<<< HEAD
     def initialize(name = '0', score = 0, date = 0)
          @name = Gtk::Entry.new
          @name.text = name
          @score = Gtk::Entry.new
          @score.text = score.to_s
          @date = Gtk::Entry.new
          @date.text = date.to_s
     end

     def print_hs
          print("#{@name.text} #{@score.text.to_i} #{@date.text.to_i}\n")
     end

     def to_str
          "#{@name.text} #{@score.text.to_i} #{@date.text.to_i}"
=======
     def initialize
          @name = Gtk::Entry.new
          @score = Gtk::Entry.new
          @date = Gtk::Entry.new
>>>>>>> 203a634da23cb022cd4c298844e902eecdd9d384
     end

end
