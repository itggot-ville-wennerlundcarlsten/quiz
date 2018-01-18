require 'sinatra'
require 'sqlite3'

get('/') do
 erb(:loaning_system)
end

post ('/students/find') do
  redirect("/students/" + params["student-id"])
end

get('/students/:id') do
  db = SQLite3::Database.new("computers_and_loans.sqlite")
  student_id = params[:id]
  result = db.execute("SELECT * FROM students WHERE id="+student_id)
  result = result[0]
  erb(:students, locals:{ student:result })
end

