require 'sinatra'

get('/hello') do
  return "<p>Hello<p>"
end

get ('/') do
  return File.read("index.html")
end

post('/add') do
  num1 = params["num1"].to_i
  num2 = params["num2"].to_i
  result = num1 + num2
  return "<p>Result: #{result}</p>"
end