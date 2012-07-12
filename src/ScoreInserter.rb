#!/usr/bin/env ruby

# Author: Gregory Maglio
# ScoreInserter.rb: Object to handle user input of HighScore record and insertion into DB.

require 'gtk2'
require 'DBHandler'
require 'HighScore'

class ScoreInserter

    attr_reader :window
    
    def initialize(myLister = ScoreLister.new)
       
         @window = Gtk::Window.new
         @window.border_width = 10
         @window.set_size_request(300, -1)
         @window.title = "High Score Management System"
         
         @window.signal_connect('delete_event') { false }
         @window.signal_connect('destroy') { false }
        
         @table = Gtk::Table.new(6,    10,    false)  # rows, columns, homogeneous
         @label1 = Gtk::Label.new("Enter the following information...")
         @nameLabel = Gtk::Label.new("Name: ")
         @scoreLabel = Gtk::Label.new("Score: ")
         @dateLabel = Gtk::Label.new("Date: ")
         @sendButton = Gtk::Button.new("Send")
        
         @scoreRec = HighScore.new # pass-through object for DB record
         
         options = Gtk::EXPAND|Gtk::FILL
                     # child, x1, x2, y1, y2, x-opt,   y-opt,   xpad, ypad
         @table.attach(@label1,         0,  10,  0,  1, options, options, 0,    0)
         @table.attach(@nameLabel,      0,   2,  1,  2, options, options, 0,    0)
         @table.attach(@scoreRec.name,  2,   6,  1,  2, options, options, 0,    0)
         @table.attach(@scoreLabel,     0,   2,  2,  3, options, options, 0,    0)
         @table.attach(@scoreRec.score, 2,   6,  2,  3, options, options, 0,    0)
         @table.attach(@dateLabel,      0,   2,  3,  4, options, options, 0,    0)
         @table.attach(@scoreRec.date,  2,   6,  3,  4, options, options, 0,    0)
         @table.attach(@sendButton,     6,  10,  1,  4, options, options, 0,    0)
         
         @theDatabase = DBHandler.new
         @sendButton.signal_connect("clicked") do
              @dialog = Gtk::MessageDialog.new(
                       window,
                       Gtk::Dialog::MODAL,
                       Gtk::MessageDialog::ERROR,
                       Gtk::MessageDialog::BUTTONS_OK,
                       ""
              )
	      fieldRegExp = /^[A-Z]{3}$/
              if @scoreRec.name.text.match(fieldRegExp).nil? and @scoreRec.score.text.to_i.<0 
                 @dialog.title = "Entry Error"
                 @dialog.set_text("Score must be more than 0 and Name must be 3 uppercase letters!")
                 @dialog.run {|r| puts "response=%d" % [r]}
                 @dialog.destroy
              elsif @scoreRec.name.text.match(fieldRegExp).nil?
                 @dialog.title = "Entry Error"
                 @dialog.set_text("Name must be 3 uppercase letters!")
                 @dialog.run {|r| puts "response=%d" % [r]}
                 @dialog.destroy
              elsif @scoreRec.score.text.to_i.<=0 
                 @dialog.title = "Entry Error"
                 @dialog.set_text("Score must be more than 0!")
                 @dialog.run {|r| puts "response=%d" % [r]}
                 @dialog.destroy
              else
                 if @theDatabase.insert_rec(@scoreRec.name.text, @scoreRec.score.text.to_i, @scoreRec.date.text.to_i).==1
                     @dialog.title = "Entry Error"
                     @dialog.set_text("Cannot insert duplicate record.")
                     @dialog.run {|r| puts "response=%d" % [r]}
                     @dialog.destroy
                 else
                     @dialog.message_type = Gtk::MessageDialog::INFO
                     @dialog.title = "Insert Successful"
                     @dialog.set_text("Insert of record is successful.")
                     @dialog.run {|r| puts "response=%d" % [r]}
                     @dialog.destroy
                     hsArray = Array.new { HighScore.new }
                     menuBarDB = DBHandler.new
                     menuBarDB.get_records.each do |x, y, z| hsArray.push(HighScore.new(x, y, z)) end
                     myLister.refresh(hsArray)
                 end
              end
         end
         @window.add(@table)
    end
end
