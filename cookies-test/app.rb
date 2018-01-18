 class App < Sinatra::Base

	require 'sinatra'
	require 'slim'
	require 'sqlite3'
	
	enable:sessions

	get('/') do
		slim(:index)
	end
	
	post('/register') do
		username = params["username"]
		password = params["password"]
		db = SQLite3::Database.new("login.sqlite")
		db.execute("INSERT INTO login (username,password) VALUES (?,?)", [username, password])
		slim(:tack)
	end
	
	post('/logga_in') do
		username = params["username"]
		password = params["password"]
		db = SQLite3::Database.new("login.sqlite")
		name = db.execute("SELECT username FROM login WHERE username=?",username)
		puts name
		if name != nil
			name = name[0][0]
			check = db.execute("SELECT password FROM login WHERE username=?",username)
			check = check[0][0]
			if check == password
				session[:yoursession] = db.execute("SELECT rowid FROM login WHERE username=?",username)
				redirect("/home/?")
			else
				puts "fel användarnamn eller lösenord"
				redirect("/")
			end
		else
			puts "användarnamn tomt"
			redirect("/")
		end
	end


	get('/home/?') do
		db = SQLite3::Database.new("login.sqlite")
		if (session[:yoursession])
			puts session[:yoursession]
			result = db.execute("SELECT username FROM login WHERE rowid=?", [session[:yoursession]])
			result = result[0][0]
			puts result
			slim(:home,locals:{result:result})
		end

	end
end