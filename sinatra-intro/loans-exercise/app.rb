require 'sinatra'
require 'sqlite3'



get('/') do
    erb(:index)
end

get('/loans') do
    erb(:id)
end

get('/loans2') do
    erb(:user)
end

get('/elever') do
    erb(:elever)
end

post('/elever/tabort') do
    db = SQLite3::Database.new('computers_and_loans.sqlite')
    name = params[:tabort]
    id = db.execute("SELECT id FROM students WHERE name LIKE '%#{name}%'")
    remove = db.execute("DELETE FROM students WHERE id = "+id)
end

post('/loans2/find') do
    redirect("/loans2/"+ params["student-name"])
end

post('/loans/find') do
    redirect("/loans/" + params["id"])
end


get('/loans/:id') do
    db = SQLite3::Database.new('computers_and_loans.sqlite')
    id = params[:id]
    result = db.execute("SELECT name FROM students WHERE id="+id)
    computer = db.execute("SELECT serial FROM computers WHERE student_id="+id)
    superresult = computer[0] + result[0]
    return superresult
end

get('/loans2/:student-name') do
    db = SQLite3::Database.new('computers_and_loans.sqlite')
    student-name = params[:student-name]
    result = db.execute("SELECT id FROM students WHERE name LIKE '%#{student-name}%'")
    computer = db.execute("SELECT serial FROM computers WHERE student_id="+result[0])
    superresult = computer[0] + result[0]
    return superresult
end

get('/elever_form') do
    erb(:create_elev)
end

get('/elever_form_remove') do
    erb(:remove_elev)
end

post('/elever_create/?') do
    name = params[:namn]
    pnr = params[:pnr]
    db = SQLite3::Database.new('computers_and_loans.sqlite')
    db.execute("INSERT INTO students(name,pnr) VALUES (?,?)",[name,pnr])
    id = db.execute("SELECT id FROM students WHERE name IS ? and pnr IS ?",[name,pnr])
    id_student = id[0][0]
    erb(:elever10, locals:{id_student:id_student, name:name, pnr:pnr})
end

post('/elever_remove/?') do
    name = params[:namn]
    pnr = params[:pnr]
    db = SQLite3::Database.new('computers_and_loans.sqlite')
    db.execute("DELETE FROM students WHERE name=?",[name])
    erb(:removed_elev, locals:{name:name})
end