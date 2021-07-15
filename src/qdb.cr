require "sqlite3"

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

  def createTable(name, collumns)
    begin
      self.database.exec("create table #{name} ( #{collumns} )")
    rescue exception
      return puts "Couldn't process table creation."
    end
  end

  def deleteTable(table)
    self.database.exec("delete table #{table}")
  end

  def selAllFrom(table)
    self.database.query("select * from #{table}")
  end

  def selFrom(item, table)
    self.database.query("select #{item} from #{table}")
  end

  def close
    self.database.close
  end
end
