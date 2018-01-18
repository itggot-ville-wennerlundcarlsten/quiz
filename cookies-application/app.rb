require 'sinatra'
require 'slim'
require 'sqlite3'

get ('/') do
    slim[:index]
end

post ('/register') do
    username = params["username"]
    password = params["password"]
    db = SQLite3::Database.new("login.sqlite")
    db.execute("INSERT INTO login (username,password) VALUES (?,?)", [username, password])
    slim[:tack]
end



get ('/logga_in')