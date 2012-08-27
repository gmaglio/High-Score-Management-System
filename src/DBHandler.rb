#!/usr/bin/env /usr/bin/ruby

# Author: Gregory Maglio
# DBHandler.rb: Object to handle DB transactions via sqlite.

require 'rubygems'
require 'sqlite3'

class DBHandler 

  def initialize(mode = "RO")
     if( mode.match("RW") ) 
         @db = SQLite3::Database.new("../data/glm.db")
         @db.execute("drop table if exists HIGH_SCORES")
     else
         @db = SQLite3::Database.new("../data/glm.db")
         @db.execute("create table if not exists HIGH_SCORES(name TEXT, score INTEGER, date INTEGER, PRIMARY KEY(name, score, date))")
     end
  end

  def insert_rec(name, score, date)
     caughtExcept = 0;
     begin
         @db.execute("insert into HIGH_SCORES values ('#{name}', #{score}, #{date})")
     rescue SQLite3::SQLException
         print "Caught constraint exception.\n"
         caughtExcept = 1
     end
     return caughtExcept
  end

  def get_records
     @db.execute("select * from HIGH_SCORES;")
  end
end
