#!/usr/bin/env /usr/bin/ruby

# Author: Gregory Maglio
# ScoreLister.rb: Object that handles the functionality of a gtk-ListBox.  ScoreLister to display list of HighScore records.

require 'gtk2'
require_relative 'HighScore'

class ScoreLister

    attr_reader :scrolled_win

    def initialize( hsList = Array.new { HighScore.new } ) 

       @field = Array.new([0, 1, 2])

       @treeview = Gtk::TreeView.new
       @renderer = Gtk::CellRendererText.new

       @column = Gtk::TreeViewColumn.new("Name", @renderer, "text" => @field[0])
       @treeview.append_column(@column)

       @column = Gtk::TreeViewColumn.new("Score", @renderer, "text" => @field[1])
       @treeview.append_column(@column)

       @column = Gtk::TreeViewColumn.new("Date", @renderer, "text" => @field[2])
       @treeview.append_column(@column)

       @store = Gtk::ListStore.new(String, Integer, Integer)

       # Add all of the products to the GtkListStore.
       hsList.each_with_index do |e, i|
           iter = @store.append
           @store.set_value(iter, @field[0], hsList[i].name.text.to_s)
           @store.set_value(iter, @field[1], hsList[i].score.text.to_i)
           @store.set_value(iter, @field[2], hsList[i].date.text.to_i)
       end

       # Add the tree model to the tree view
       @treeview.model = @store

       @scrolled_win = Gtk::ScrolledWindow.new
       @scrolled_win.add(@treeview)
       @scrolled_win.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
   
    end 

    def refresh( hsList = Array.new { HighScore.new } ) 
       @store.clear # clear what was already posted to the list.
       hsList.each_with_index do |e, i| # rebuild list here
           iter = @store.append
           @store.set_value(iter, @field[0], hsList[i].name.text.to_s)
           @store.set_value(iter, @field[1], hsList[i].score.text.to_i)
           @store.set_value(iter, @field[2], hsList[i].date.text.to_i)
       end
    end

end
