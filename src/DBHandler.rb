#!/usr/bin/env /usr/bin/ruby
require 'sqlite3'

class DBHandler 

  def initialize
     @db = SQLite3::Database.new("../data/glm.db")
     @db.execute("drop table if exists HIGH_SCORES")
     @db.execute("create table HIGH_SCORES(name TEXT, score INTEGER, date INTEGER, PRIMARY KEY(name, score, date))")
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

end
