#!/usr/bin/env /usr/bin/ruby
<<<<<<< HEAD

# Author: Gregory Maglio
# DBHandler.rb: Object to handle DB transactions via sqlite.

=======
>>>>>>> 203a634da23cb022cd4c298844e902eecdd9d384
require 'sqlite3'

class DBHandler 

<<<<<<< HEAD
  def initialize(mode = "RO")
     if( mode.match("RW") ) 
         @db = SQLite3::Database.new("../data/glm.db")
         @db.execute("drop table if exists HIGH_SCORES")
     else
         @db = SQLite3::Database.new("../data/glm.db")
         @db.execute("create table if not exists HIGH_SCORES(name TEXT, score INTEGER, date INTEGER, PRIMARY KEY(name, score, date))")
     end
=======
  def initialize
     @db = SQLite3::Database.new("../data/glm.db")
     @db.execute("drop table if exists HIGH_SCORES")
     @db.execute("create table HIGH_SCORES(name TEXT, score INTEGER, date INTEGER, PRIMARY KEY(name, score, date))")
>>>>>>> 203a634da23cb022cd4c298844e902eecdd9d384
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

<<<<<<< HEAD
  def get_records
     @db.execute("select * from HIGH_SCORES;")
  end

=======
>>>>>>> 203a634da23cb022cd4c298844e902eecdd9d384
end
