require "sqlite3"
require "db"

# a

class QDB
  def self.open(directory, name, retry_attempts, retry_delay) : self
    new directory, name, retry_attempts, retry_delay
  end

  def self.open(directory, name) : self
    new directory, name
  end

  getter database : DB::Database { DB.open "sqlite3://#{@directory}/#{@name}?retry_attempts=#{@retry_attempts}&retry_delay=#{@retry_delay}" }

  @directory : String
  @name : String
  @retry_attempts : Int32
  @retry_delay : Int32

  def initialize(@directory : String, @name : String, @retry_attempts : Int32 = 1, @retry_delay : Int32 = 1)
  end

  def exec(argument : String)
    begin
      self.database.exec(argument)
    rescue exception
      return puts "Couldn't process command."
    end
  end

  def createTable(name, collumns : Array)
    begin
      self.database.exec "create table #{name} (#{collumns.join(", ")})"
    rescue exception
      return puts "Table error"
    end
  end

  def deleteTable(table)
    begin
      self.database.exec("delete table #{table}")
    rescue exception
      return puts "Table was not deleted"
    end
  end

  def selAllFrom(table)
    begin
      self.database.query("select * from #{table}")
    rescue exception
      return puts "Selection error"
    end
  end

  def selFrom(item, table)
    begin
      self.database.query("select #{item} from #{table}")
    rescue exception
      return puts "Selection error"
    end
  end

  def close
    begin
      self.database.close
    rescue exception
      return puts "AAAAAAAAAAAAAAAAAAA"
    end
  end
end
