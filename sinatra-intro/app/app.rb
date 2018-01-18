require 'sinatra'
require 'sqlite3'

get('/') do
    erb(:index, locals:{ greeting: "Hello from index!" })
end


get('/allaartister') do
    db = SQLite3::Database.new('./db/music.sqlite')
    result = db.execute("SELECT Name FROM artists")
    result2 = db.execute("SELECT ArtistId from artists")
     erb(:allaartister, locals:{result:result,result2:result2})
end

get('/enartist') do
    db = SQLite3::Database.new('./db/music.sqlite')
    id = 1
    result = db.execute("SELECT * FROM artists WHERE ArtistId='#{id}'")
    erb(:enartist, locals:{result:result})
end

post('/skapaartist/?') do
    name = params[:name]
    db = SQLite3::Database.new('./db/music.sqlite')
    db.execute("INSERT INTO artists(Name) VALUES (?)", [name])
    result = db.execute("SELECT * FROM Artists WHERE Name='#{name}'") 
    erb(:nyartist, locals:{namn:result})
end

get('/allaalbum') do
    db = SQLite3::Database.new('./db/music.sqlite')
    result = db.execute("SELECT AlbumId FROM albums order by AlbumId asc")
    result2 = db.execute("SELECT Title FROM albums")
    result3 = []
    i = 0
    while i < result.length
        kalle = db.execute("SELECT Name FROM artists WHERE ArtistId in(SELECT ArtistId FROM albums WHERE AlbumId='#{result[i][0]}')")
        result3 << kalle[0]
        i += 1
    end

    erb(:allaalbum, locals:{result:result,result2:result2,result3:result3})
end

get('/ettalbum') do
    db = SQLite3::Database.new('./db/music.sqlite')
    id = 1
    result = db.execute("SELECT * FROM albums WHERE AlbumId='#{id}'")
    erb(:ettalbum, locals:{result:result})
end