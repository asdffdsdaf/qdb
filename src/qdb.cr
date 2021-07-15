require "sqlite3"

# why

class QDB

    @database = uninitialized DB::Database

    def database
        @database
    end

    def exec(argument : String)
        return @database.exec(argument)
    end

    def createTable(name, collumns)
        begin
            return @database.exec("create table #{name} ( #{collumns} )")
        rescue exception
            return "Couldn't process: #{self}"
        end
    end
    
    def deleteTable(table)
        return @database.exec("delete table #{table}")
    end

    def selAllFrom(table) 
        return @database.query("select * from #{table}")
    end

    def selFrom(item, table) 
        return @database.query("select #{item} from #{table}")
    end

    def open(directory, name) 
        @database = DB.open "sqlite3://#{directory}/#{name}" 
    end

    def open(directory, name, retryAttempts, retryDelay) 
        @database = DB.open "sqlite3://#{directory}/#{name}?retry_attempts=#{retryAttempts}&retry_delay=#{retryDelay}" 
    end
    
    def close () ( @database.close ) end
end