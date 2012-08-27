#!/usr/bin/env /usr/bin/ruby

# Author: Gregory Maglio
# MenuBar.rb: Object that describes a MenuBar implemented in gtk2.

require 'rubygems'
require 'gtk2'
require 'sqlite3'

class MenuBar

    attr_reader :group
    attr_reader :menubar

    def initialize(myLister = ScoreLister.new)

        @group = Gtk::AccelGroup.new
        @menubar = Gtk::MenuBar.new
        
        filemenu = Gtk::Menu.new
        viewmenu = Gtk::Menu.new
        editmenu = Gtk::Menu.new
        helpmenu = Gtk::Menu.new
        
        file = Gtk::MenuItem.new("File")
        view = Gtk::MenuItem.new("View")
        edit = Gtk::MenuItem.new("Edit")
        help = Gtk::MenuItem.new("Help")
        
        file.submenu = filemenu
        view.submenu = viewmenu
        edit.submenu = editmenu
        help.submenu = helpmenu
        
        @menubar.append(file)
        @menubar.append(view)
        @menubar.append(edit)
        @menubar.append(help)
        
        # Create the File menu content.
        new = Gtk::ImageMenuItem.new(Gtk::Stock::NEW, group)
        open = Gtk::ImageMenuItem.new(Gtk::Stock::OPEN, group)
        close = Gtk::ImageMenuItem.new(Gtk::Stock::CLOSE, group)
        filemenu.append(new)
        filemenu.append(open)
        filemenu.append(close)
        
        # Create the Edit menu content.
        cut   = Gtk::ImageMenuItem.new(Gtk::Stock::CUT, group);
        copy  = Gtk::ImageMenuItem.new(Gtk::Stock::COPY, group);
        paste = Gtk::ImageMenuItem.new(Gtk::Stock::PASTE, group);
        editmenu.append(cut)
        editmenu.append(copy)
        editmenu.append(paste)
        
        # Create the Help menu content.
        contents = Gtk::ImageMenuItem.new(Gtk::Stock::HELP, group)
        about    = Gtk::ImageMenuItem.new(Gtk::Stock::ABOUT, group)
        helpmenu.append(contents)
        helpmenu.append(about)
   
        # Create the View menu content.
        refresh = Gtk::ImageMenuItem.new(Gtk::Stock::REFRESH, group)
        viewmenu.append(refresh)
       
        # signals, wiring it up! 
        new.signal_connect('activate') do 
            insertBox = ScoreInserter.new(myLister)
            insertBox.window.show_all
        end

        open.signal_connect('activate') do 
            print "open item\n" 
        end

        close.signal_connect('activate') do 
            Gtk.main_quit 
        end

        refresh.signal_connect('activate') do
            hsArray = Array.new { HighScore.new }
            menuBarDB = DBHandler.new
            menuBarDB.get_records.each do |x, y, z| hsArray.push(HighScore.new(x, y, z)) end
            myLister.refresh(hsArray)
        end

    end
end
