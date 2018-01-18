class App < Sinatra::Base
	enable :sessions
	
	get ('/') do
		slim :index
	end

	get ('/admin') do
		if session[:admin]
			return "only admins"
		else
			return "forbidden"
		
		end
	end
	
	post('/login') do
		if params["username"] == "admin" && params["passwod"] == "letmein"
			session[:admin] = true
			redirect('/admin')
		else
			redirect('/')
		end
	end
end

