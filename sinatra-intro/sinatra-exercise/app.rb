require 'sinatra'
require 'sqlite3'

get('/') do
  return File.read("index.html")
end

post('/login') do
  username = params['user']
  passwordinput = params['losen']
  if username == "bananpaj"
    if passwordinput == "grillkorv"
      return "Grattis"
    end
  end
  return "åtkomst nekad"
end

get('/students') do
  db = SQLite3::Database.new('computers_and_loans.sqlite')
  result = db.execute("SElECT name FROM Students")
  response = "<ul>"
  i = 0
  while i < result.length
    name = result[i][0]
    response += "<li>" + name + "</li>"
    i += 1
  end

  return response
end