require 'sqlite3'

def migrate(db)
    begin     
        db.execute "CREATE TABLE IF NOT EXISTS todo(Id INTEGER PRIMARY KEY AUTOINCREMENT, 
            task TEXT NOT NULL, is_done BOOLEAN)"

    rescue SQLite3::Exception => e 
        
        puts "Exception occurred"
        puts e
        
    # ensure
    #     db.close if db
    end
end
